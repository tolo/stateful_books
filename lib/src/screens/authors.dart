// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:result_notifier/result_notifier.dart';

import 'package:stateful_books/src/data/author.dart';
import 'package:stateful_books/src/domain/library_service.dart';
import 'package:stateful_books/src/extensions/widget_extensions.dart';
import 'package:stateful_books/src/widgets/author_list.dart';

/// A screen that displays a list of authors.
class AuthorsScreen extends WatcherWidget {
  /// Creates an [AuthorsScreen].
  const AuthorsScreen({super.key});

  /// The title of the screen.
  static const String title = 'Authors';

  @override
  Widget build(WatcherContext context) {
    final authors = libraryService.allAuthors.watch(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: switch (authors) {
        Data(data: var d) => AuthorList(
            authors: d,
            onTap: (author) => _handleAuthorTapped(context, author)),
        Error(error: var e) => Text('Error loading books: $e'),
        Loading() => const CircularProgressIndicator().centered(),
      },
    );
  }

  void _handleAuthorTapped(BuildContext context, Author author) {
    context.go('/author/${author.id}', extra: author);
  }
}
