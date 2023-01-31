// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:stateful_books/src/widgets/future_widget.dart';
import 'package:stateful_books_client/stateful_books_client.dart';

/// The book list view.
class BookList extends StatelessWidget {
  /// Creates an [BookList].
  const BookList({
    required this.books,
    this.onTap,
    Key? key,
  }) : super(key: key);

  /// The list of books to be displayed.
  final Future<List<Book>> books;

  /// Called when the user taps a book.
  final ValueChanged<Book>? onTap;

  @override
  Widget build(BuildContext context) {
    return FutureWidget<List<Book>>(
      future: books,
      builder: _bookList,
    );
  }

  Widget _bookList(BuildContext context, List<Book> books) => ListView.builder(
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(
            books[index].title,
          ),
          subtitle: Text(
            books[index].authorName ?? '-',
          ),
          onTap: onTap != null ? () => onTap!(books[index]) : null,
        ),
      );
}
