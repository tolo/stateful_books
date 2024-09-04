// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:result_notifier/result_notifier.dart';

import 'package:stateful_books/src/data/book.dart';
import 'package:stateful_books/src/domain/library_service.dart';
import 'package:stateful_books/src/extensions/widget_extensions.dart';
import 'package:stateful_books/src/widgets/book_list.dart';

/// A screen that displays a list of books.
class BooksScreen extends StatefulWidget {
  /// Creates a [BooksScreen].
  const BooksScreen(this.kind, {super.key});

  /// Which tab to display.
  final String kind;

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didUpdateWidget(BooksScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    _tabController.index = switch (widget.kind) {
      'popular' => 0,
      'new' => 1,
      _ => 2, // 'all'
    };
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        bottom: TabBar(
          controller: _tabController,
          onTap: _handleTabTapped,
          tabs: const <Tab>[
            Tab(
              text: 'Popular',
              icon: Icon(Icons.people),
            ),
            Tab(
              text: 'New',
              icon: Icon(Icons.new_releases),
            ),
            Tab(
              text: 'All',
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _booksList(libraryService.popularBooks),
          _booksList(libraryService.newBooks),
          _booksList(libraryService.allBooks),
        ],
      ),
    );
  }

  Widget _booksList(ValueListenable<Result<Books>> listenable) {
    return Watcher(builder: (context) {
      final books = listenable.watch(context);
      return switch (books) {
        Data(data: var d) => BookList(books: d, onTap: _handleBookTapped),
        Error(error: var e) => Text('Error loading books: $e'),
        Loading() => const CircularProgressIndicator().centered(),
      };
    });
  }

  void _handleBookTapped(Book book) {
    context.go('/book/${book.id}', extra: book);
  }

  void _handleTabTapped(int index) {
    final path = switch (index) {
      1 => '/books/new',
      2 => '/books/all',
      _ => '/books/popular',
    };
    context.go(path);
  }
}
