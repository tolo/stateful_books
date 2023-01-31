// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stateful_books/src/application_context.dart';
import 'package:stateful_books/src/widgets/future_widget.dart';
import 'package:stateful_books_client/stateful_books_client.dart';
import 'package:url_launcher/link.dart';

import 'author_details.dart';

/// A screen to display book details.
class BookDetailsScreen extends StatelessWidget {
  /// Creates a [BookDetailsScreen].
  const BookDetailsScreen({
    Key? key,
    this.bookId,
  }) : super(key: key);

  /// The book to be displayed.
  final int? bookId;

  @override
  Widget build(BuildContext context) {
    final library = ApplicationContextProvider.of(context).library;
    if (bookId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Book'),
        ),
        body: const Center(
          child: Text('No book found.'),
        ),
      );
    }
    return FutureWidget<Book>(
      future: library.bookById(bookId!),
      builder: _bookDetails,
    );
  }

  Widget _bookDetails(BuildContext context, Book book) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        ),
        body: Center(
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(
              book.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Padding(padding: EdgeInsets.all(4.0)),
            Text(
              book.authorName ?? '-',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            TextButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AuthorDetailsScreen(authorId: book.authorId),
                  ),
                );
              },
              child: const Text('View author (navigator.push)'),
            ),
            Link(
              uri: Uri.parse('/author/${book.authorId}'),
              builder: (BuildContext context, FollowLink? followLink) =>
                  TextButton(
                    onPressed: followLink,
                    child: const Text('View author (Link)'),
                  ),
            ),
            TextButton(
              onPressed: () {
                context.push('/author/${book.authorId}');
              },
              child: const Text('View author (GoRouter.push)'),
            ),
          ],
        ),
      ),
    );
  }
}
