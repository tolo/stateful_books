// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:stateful_books/src/data/book.dart';
import 'package:stateful_books/src/widgets/entity_list.dart';

/// The book list view.
class BookList extends EntityList<Book> {
  /// Creates an [BookList].
  const BookList({
    required List<Book> books,
    super.onTap,
    super.key,
  }) : super(entities: books);

  @override
  String titleFor(Book entity) => entity.title;

  @override
  String subtitleFor(Book entity) => entity.author.name;
}
