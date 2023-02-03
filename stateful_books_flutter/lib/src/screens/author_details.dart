// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stateful_books/src/data/library_api.dart';
import 'package:stateful_books/src/widgets/future_widget.dart';
import 'package:stateful_books/src/widgets/stateless_widget_base.dart';
import 'package:stateful_books/src/widgets/widget_utils.dart';
import 'package:stateful_books_client/stateful_books_client.dart';

import '../widgets/book_list.dart';

/// The author detail screen.
class AuthorDetailsScreen extends StatelessWidgetBase with WidgetAdditions {
  /// Creates an author detail screen.
  const AuthorDetailsScreen({
    required super.appContext,
    required this.authorId,
    Key? key,
  }) : super(key: key);

  /// The author to be displayed.
  final int? authorId;

  @override
  Widget build(BuildContext context) {
    if (authorId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Author'),
        ),
        body: const Center(
          child: Text('No author found.'),
        ),
      );
    }
    return FutureWidget<Author>(
      future: appContext.library.authorById(authorId!),
      builder: (context, data) => _authorDetails(context, appContext.library, data),
    );
  }

  Widget _authorDetails(BuildContext context, LibraryApi library, Author author) {
    return Scaffold(
      appBar: AppBar(
        title: Text(author.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteAuthor(context, author);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: BookList(
                books: library.booksByAuthor(author),
                onTap: (Book book) => context.go('/book/${book.id}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteAuthor(BuildContext context, Author author) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (author.bookCount! > 0) {
      showSnack(scaffoldMessenger, 'Cannot delete author with books');
      return;
    }
    final navigator = Navigator.of(context);

    try {
      await appContext.library.deleteAuthor(author.id!);
      showSnack(scaffoldMessenger, 'Author deleted!');
      navigator.pop();
    } catch (e) {
      showSnack(scaffoldMessenger, 'Error deleting author: $e');
    }
  }
}
