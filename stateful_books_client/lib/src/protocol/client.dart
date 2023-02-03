/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:stateful_books_client/src/protocol/book.dart' as _i3;
import 'package:stateful_books_client/src/protocol/author.dart' as _i4;
import 'package:serverpod_auth_client/module.dart' as _i5;
import 'dart:io' as _i6;
import 'protocol.dart' as _i7;

class _EndpointLibrary extends _i1.EndpointRef {
  _EndpointLibrary(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'library';

  _i2.Future<int> bookCount() => caller.callServerEndpoint<int>(
        'library',
        'bookCount',
        {},
      );

  _i2.Future<List<_i3.Book>> allBooks() =>
      caller.callServerEndpoint<List<_i3.Book>>(
        'library',
        'allBooks',
        {},
      );

  _i2.Future<List<_i3.Book>> popularBooks() =>
      caller.callServerEndpoint<List<_i3.Book>>(
        'library',
        'popularBooks',
        {},
      );

  _i2.Future<List<_i3.Book>> newBooks() =>
      caller.callServerEndpoint<List<_i3.Book>>(
        'library',
        'newBooks',
        {},
      );

  _i2.Future<List<_i3.Book>> booksByAuthor(_i4.Author author) =>
      caller.callServerEndpoint<List<_i3.Book>>(
        'library',
        'booksByAuthor',
        {'author': author},
      );

  _i2.Future<_i3.Book?> bookById(int bookId) =>
      caller.callServerEndpoint<_i3.Book?>(
        'library',
        'bookById',
        {'bookId': bookId},
      );

  _i2.Future<void> createBook(_i3.Book book) => caller.callServerEndpoint<void>(
        'library',
        'createBook',
        {'book': book},
      );

  _i2.Future<void> updateBook(_i3.Book book) => caller.callServerEndpoint<void>(
        'library',
        'updateBook',
        {'book': book},
      );

  _i2.Future<void> deleteBook(int bookId) => caller.callServerEndpoint<void>(
        'library',
        'deleteBook',
        {'bookId': bookId},
      );

  _i2.Future<List<_i4.Author>> allAuthors() =>
      caller.callServerEndpoint<List<_i4.Author>>(
        'library',
        'allAuthors',
        {},
      );

  _i2.Future<_i4.Author?> authorById(int authorId) =>
      caller.callServerEndpoint<_i4.Author?>(
        'library',
        'authorById',
        {'authorId': authorId},
      );

  _i2.Future<void> createAuthor(_i4.Author author) =>
      caller.callServerEndpoint<void>(
        'library',
        'createAuthor',
        {'author': author},
      );

  _i2.Future<void> updateAuthor(_i4.Author author) =>
      caller.callServerEndpoint<void>(
        'library',
        'updateAuthor',
        {'author': author},
      );

  _i2.Future<void> deleteAuthor(int authorId) =>
      caller.callServerEndpoint<void>(
        'library',
        'deleteAuthor',
        {'authorId': authorId},
      );
}

class _Modules {
  _Modules(Client client) {
    auth = _i5.Caller(client);
  }

  late final _i5.Caller auth;
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i6.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i7.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    library = _EndpointLibrary(this);
    modules = _Modules(this);
  }

  late final _EndpointLibrary library;

  late final _Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {'library': library};
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
