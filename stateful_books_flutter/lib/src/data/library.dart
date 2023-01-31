// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:stateful_books_client/stateful_books_client.dart';

/// A library that contains books and authors.
class Library {

  Library(this.client);

  final Client client;

  /// The books in the library.
  Future<List<Book>> get allBooks => client.library.allBooks();

  /// The authors in the library.
  Future<List<Author>> get allAuthors => client.library.allAuthors();

  /// The list of popular books in the library.
  Future<List<Book>> get popularBooks => client.library.popularBooks();

  /// The list of new books in the library.
  Future<List<Book>> get newBooks => client.library.newBooks();

  /// The books by the given [author].
  Future<List<Book>> booksByAuthor(Author author) => client.library.booksByAuthor(author);

  Future<Book?> bookById(int bookId) => client.library.bookById(bookId);

  Future<Author?> authorById(int authorId) => client.library.authorById(authorId);
}
