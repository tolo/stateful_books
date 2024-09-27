// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import 'package:stateful_books/src/data/book.dart';
import 'package:stateful_books/src/domain/library_service.dart';
import 'package:stateful_books/src/screens/author_details.dart';
import 'package:stateful_books/src/widgets/loader.dart';

/// A screen to display book details.
class BookDetailsScreen extends StatelessWidget {
  static Widget loadBook(int bookId, Book? initiallySelected) {
    return Loader<Book?>(
      listenable: libraryService.getBookById(bookId),
      builder: (book) => BookDetailsScreen(book: book ?? initiallySelected),
    );
  }

  /// Creates a [BookDetailsScreen].
  const BookDetailsScreen({
    super.key,
    this.book,
  });

  /// The book to be displayed.
  final Book? book;

  @override
  Widget build(BuildContext context) {
    if (book == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('‍😢'),
        ),
        body: const Center(
          child: Text('Book not found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(book!.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                book!.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Text(
              book!.author.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AuthorDetailsScreen(author: book!.author),
                  ),
                );
              },
              child: const Text('View author (navigator.push)'),
            ),
            Link(
              uri: Uri.parse('/author/${book!.author.id}'),
              builder: (BuildContext context, FollowLink? followLink) =>
                  TextButton(
                onPressed: followLink,
                child: const Text('View author (Link)'),
              ),
            ),
            TextButton(
              onPressed: () {
                context.push('/author/${book!.author.id}');
              },
              child: const Text('View author (GoRouter.push)'),
            ),
          ],
        ),
      ),
    );
  }
}
