// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stateful_books/src/application_context.dart';
import 'package:stateful_books_client/stateful_books_client.dart';

import '../widgets/author_list.dart';

/// A screen that displays a list of authors.
class AuthorsScreen extends StatelessWidget {
  /// Creates an [AuthorsScreen].
  const AuthorsScreen({Key? key}) : super(key: key);

  /// The title of the screen.
  static const String title = 'Authors';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: _authorList(context),
      );

  Widget _authorList(BuildContext context) {
    final library = ApplicationContextProvider.of(context).library;
    return AuthorList(
      authors: library.allAuthors,
      onTap: (Author author) {
        context.go('/author/${author.id}');
      },
    );
  }
}
