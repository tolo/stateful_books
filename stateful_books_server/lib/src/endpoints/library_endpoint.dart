import 'package:serverpod/server.dart';
import 'package:stateful_books_server/src/generated/author.dart';
import 'package:stateful_books_server/src/generated/book.dart';


class LibraryEndpoint extends Endpoint {
  Future<int> bookCount(Session session) async {
    return Book.count(session);
  }

  Future<Book?> _withAuthor(Book? book, Session session) async {
    book?.authorName = (await Author.findById(session, book.authorId))?.name;
    return book;
  }

  Future<List<Book>> _withAuthors(List<Book> books, Session session) async {
    for(var book in books) {
      await _withAuthor(book, session);
    }
    return books;
  }

  Future<List<Book>> allBooks(Session session) async {
    return _withAuthors(await Book.find(session), session);
  }

  Future<List<Book>> popularBooks(Session session) async {
    return _withAuthors(await Book.find(session, where: (t) => t.isPopular.equals(true)), session);
  }

  Future<List<Book>> newBooks(Session session) async {
    return _withAuthors(await Book.find(session, where: (t) => t.isNew.equals(true)), session);
  }

  Future<List<Book>> booksByAuthor(Session session, Author author) async {
    return _withAuthors(await Book.find(session, where: (t) => t.authorId.equals(author.id!)), session);
  }

  Future<List<Author>> allAuthors(Session session) async {
    List<Author> authors = await Author.find(session);
    for(var author in authors) {
      author.bookCount = await Book.count(session, where: (t) => t.authorId.equals(author.id!));
    }
    return authors;
  }

  Future<Book?> bookById(Session session, int bookId) async {
    return _withAuthor(await Book.findById(session, bookId), session);
  }

  Future<Author?> authorById(Session session, int authorId) async {
    return Author.findById(session, authorId);
  }
}
