// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stateful_books/src/application_context.dart';
import 'package:stateful_books/src/data/library.dart';
import 'package:stateful_books/src/widgets/future_widget.dart';
import 'package:stateful_books_client/stateful_books_client.dart';

import '../widgets/book_list.dart';

/// The author detail screen.
class AuthorDetailsScreen extends StatelessWidget {
  /// Creates an author detail screen.
  const AuthorDetailsScreen({
    required this.authorId,
    Key? key,
  }) : super(key: key);

  /// The author to be displayed.
  final int? authorId;

  @override
  Widget build(BuildContext context) {
    final library = ApplicationContextProvider.of(context).library;
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
      future: library.authorById(authorId!),
      builder: (context, data) => _authorDetails(context, library, data),
    );
  }

  Widget _authorDetails(BuildContext context, Library library, Author author) {
    return Scaffold(
      appBar: AppBar(
        title: Text(author.name),
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
}
