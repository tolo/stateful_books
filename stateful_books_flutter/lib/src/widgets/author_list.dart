// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:stateful_books/src/widgets/future_widget.dart';
import 'package:stateful_books_client/stateful_books_client.dart';

/// The author list view.
class AuthorList extends StatelessWidget {
  /// Creates an [AuthorList].
  const AuthorList({
    required this.authors,
    this.onTap,
    Key? key,
  }) : super(key: key);

  /// The list of authors to be shown.
  final Future<List<Author>> authors;

  /// Called when the user taps an author.
  final ValueChanged<Author>? onTap;

  @override
  Widget build(BuildContext context) {
    return FutureWidget<List<Author>>(
      future: authors,
      builder: _authorList,
    );
  }

  Widget _authorList(BuildContext context, List<Author> authors) => ListView.builder(
        itemCount: authors.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(
            authors[index].name,
          ),
          subtitle: Text(
            '${authors[index].bookCount ?? 0} books',
          ),
          onTap: onTap != null ? () => onTap!(authors[index]) : null,
        ),
      );
}
