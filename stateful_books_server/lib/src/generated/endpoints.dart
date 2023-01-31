/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/library_endpoint.dart' as _i2;
import 'package:stateful_books_server/src/generated/author.dart' as _i3;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'library': _i2.LibraryEndpoint()
        ..initialize(
          server,
          'library',
          null,
        )
    };
    connectors['library'] = _i1.EndpointConnector(
      name: 'library',
      endpoint: endpoints['library']!,
      methodConnectors: {
        'bookCount': _i1.MethodConnector(
          name: 'bookCount',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['library'] as _i2.LibraryEndpoint).bookCount(session),
        ),
        'allBooks': _i1.MethodConnector(
          name: 'allBooks',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['library'] as _i2.LibraryEndpoint).allBooks(session),
        ),
        'popularBooks': _i1.MethodConnector(
          name: 'popularBooks',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['library'] as _i2.LibraryEndpoint)
                  .popularBooks(session),
        ),
        'newBooks': _i1.MethodConnector(
          name: 'newBooks',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['library'] as _i2.LibraryEndpoint).newBooks(session),
        ),
        'booksByAuthor': _i1.MethodConnector(
          name: 'booksByAuthor',
          params: {
            'author': _i1.ParameterDescription(
              name: 'author',
              type: _i1.getType<_i3.Author>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['library'] as _i2.LibraryEndpoint).booksByAuthor(
            session,
            params['author'],
          ),
        ),
        'allAuthors': _i1.MethodConnector(
          name: 'allAuthors',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['library'] as _i2.LibraryEndpoint).allAuthors(session),
        ),
        'bookById': _i1.MethodConnector(
          name: 'bookById',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['library'] as _i2.LibraryEndpoint).bookById(
            session,
            params['bookId'],
          ),
        ),
        'authorById': _i1.MethodConnector(
          name: 'authorById',
          params: {
            'authorId': _i1.ParameterDescription(
              name: 'authorId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['library'] as _i2.LibraryEndpoint).authorById(
            session,
            params['authorId'],
          ),
        ),
      },
    );
  }
}
