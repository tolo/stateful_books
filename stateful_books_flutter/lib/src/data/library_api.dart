// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:stateful_books_client/stateful_books_client.dart';

/// A library that contains books and authors.
class LibraryApi {

  LibraryApi(this.client);

  final Client client;


  /// The books in the library.
  Future<List<Book>> get allBooks => client.library.allBooks();

  /// The list of popular books in the library.
  Future<List<Book>> get popularBooks => client.library.popularBooks();

  /// The list of new books in the library.
  Future<List<Book>> get newBooks => client.library.newBooks();

  /// The books by the given [author].
  Future<List<Book>> booksByAuthor(Author author) => client.library.booksByAuthor(author);

  Future<Book?> bookById(int bookId) => client.library.bookById(bookId);

  Future<void> createBook(String title, Author author) =>
      client.library.createBook(Book(title: title, authorId: author.id!, isPopular: true, isNew: true));

  Future<void> updateBook(Book book) => client.library.updateBook(book);

  Future<void> deleteBook(int bookId) => client.library.deleteBook(bookId);


  /// The authors in the library.
  Future<List<Author>> get allAuthors => client.library.allAuthors();

  Future<Author?> authorById(int authorId) => client.library.authorById(authorId);

  Future<void> createAuthor(String name) => client.library.createAuthor(Author(name: name));

  Future<void> updateAuthor(Author author) => client.library.updateAuthor(author);

  Future<void> deleteAuthor(int authorId) => client.library.deleteAuthor(authorId);
}
