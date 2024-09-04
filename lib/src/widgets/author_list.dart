// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:stateful_books/src/data/author.dart';
import 'package:stateful_books/src/widgets/entity_list.dart';

/// The author list view.
class AuthorList extends EntityList<Author> {
  /// Creates an [AuthorList].
  const AuthorList({
    required List<Author> authors,
    super.onTap,
    super.key,
  }) : super(entities: authors);

  @override
  String titleFor(Author entity) => entity.name;

  @override
  String subtitleFor(Author entity) => '${entity.books.length} books';
}
