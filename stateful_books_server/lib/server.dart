import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart' as auth;
import 'package:stateful_books_server/src/endpoints/library_endpoint.dart';

import 'package:stateful_books_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      print('sendValidationEmail - $email - validationCode: $validationCode');
      // Send your validation email here.
      return true;
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      // Send a password reset email here.
      return true;
    },
  ));

  // Seed the database with some initial data.
  await _seedDatabase(pod);

  // Start the server.
  await pod.start();
}

Future<void> _seedDatabase(Serverpod pod) async {
  Session? session;
  try {
    session = await pod.createSession();
    final library = pod.endpoints.getConnectorByName('library')?.endpoint as LibraryEndpoint;
    final bookCount = await library.bookCount(session);
    if (bookCount == 0) {
      session.log('Seeding books...');
      await session.db.transaction((transaction) async {
        Author author = await _addAuthor(session!, name: 'Philip K. Dick');
        await _addBook(session, title: 'Do Androids Dream of Electric Sheep?', authorId: author.id!, isPopular: false, isNew: false);
        await _addBook(session, title: 'A Scanner Darkly', authorId: author.id!, isPopular: false, isNew: false);

        author = await _addAuthor(session, name: 'J. R. R. Tolkien');
        await _addBook(session, title: 'The Hobbit', authorId: author.id!, isPopular: true, isNew: false);
        await _addBook(session, title: 'The Lord of the Rings', authorId: author.id!, isPopular: true, isNew: false);
        await _addBook(session, title: 'The Silmarillion', authorId: author.id!, isPopular: false, isNew: false);

        author = await _addAuthor(session, name: 'S.A. Corey');
        await _addBook(session, title: 'Leviathan Wakes', authorId: author.id!, isPopular: true, isNew: false);
        await _addBook(session, title: 'Caliban\'s War', authorId: author.id!, isPopular: false, isNew: false);
        await _addBook(session, title: 'Abaddon\'s Gate', authorId: author.id!, isPopular: false, isNew: false);
        await _addBook(session, title: 'Cibola Burn', authorId: author.id!, isPopular: true, isNew: false);
        await _addBook(session, title: 'Nemesis Games', authorId: author.id!, isPopular: false, isNew: false);
        await _addBook(session, title: 'Babylon\'s Ashes', authorId: author.id!, isPopular: false, isNew: false);
        await _addBook(session, title: 'Persepolis Rising', authorId: author.id!, isPopular: false, isNew: true);
        await _addBook(session, title: 'Tiamat\'s Wrath', authorId: author.id!, isPopular: true, isNew: true);
        await _addBook(session, title: 'Leviathan Falls', authorId: author.id!, isPopular: true, isNew: true);
      });
      session.log('Done seeding books data.');
    } else {
      session.log('Database contains $bookCount books - skipping seeding.');
    }

    final user = await auth.Users.findUserByIdentifier(session, 'admin');
    if (user == null) {
      session.log('Seeding users...');
      final user = await auth.Users.createUser(session, auth.UserInfo(userIdentifier: 'admin', userName: 'admin', email: 'admin@dev.null',
          created: DateTime.now(), scopeNames: [Scope.admin.name!], blocked: false));
      if (user != null) {
        final emailAuth = auth.EmailAuth(userId: user.id!, email: user.email!, hash: auth.Emails.generatePasswordHash('password', user.email!));
        await auth.EmailAuth.insert(session, emailAuth);
      }
      session.log('Done seeding users.');
    }

  } finally {
    session?.close();
  }
}

Future<Author> _addAuthor(Session session, {Transaction? transaction, required String name}) async {
  final author = Author(name: name, bookCount: 0);
  await Author.insert(session, author, transaction: transaction);
  return author;
}

Future<Book> _addBook(Session session, {
  Transaction? transaction,
  required String title,
  required int authorId,
  required bool isPopular,
  required bool isNew,
}) async {
  final book = Book(title: title, authorName: '', authorId: authorId, isPopular: isPopular, isNew: isNew);
  await Book.insert(session, book, transaction: transaction);
  return book;
}