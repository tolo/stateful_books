// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:stateful_books/src/data/author.dart';
import 'package:stateful_books/src/data/book.dart';
import 'package:stateful_books/src/domain/library_service.dart';
import 'package:stateful_books/src/widgets/loader.dart';
import 'package:stateful_books/src/widgets/book_list.dart';

/// The author detail screen.
class AuthorDetailsScreen extends StatelessWidget {
  static Widget loadAuthor(int authorId) {
    return Loader<Author?>(
      listenable: libraryService.getAuthorById(authorId),
      builder: (author) => AuthorDetailsScreen(author: author),
    );
  }

  /// Creates an author detail screen.
  const AuthorDetailsScreen({
    required this.author,
    super.key,
  });

  /// The author to be displayed.
  final Author? author;

  @override
  Widget build(BuildContext context) {
    if (author == null) {
      return const Scaffold(
        body: Center(
          child: Text('No author found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(author!.name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: BookList(
                books: author!.books,
                onTap: (Book book) => context.go('/book/${book.id}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
