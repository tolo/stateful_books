// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:stateful_books/src/domain/library_service.dart';

import 'author.dart';
import 'book.dart';

/// Library data mock.
final LibraryApi libraryInstance = LibraryApi()
  .._addBook(
      title: 'Left Hand of Darkness',
      authorName: 'Ursula K. Le Guin',
      isPopular: true,
      isNew: true)
  .._addBook(
      title: 'Too Like the Lightning',
      authorName: 'Ada Palmer',
      isPopular: false,
      isNew: true)
  .._addBook(
      title: 'Kindred',
      authorName: 'Octavia E. Butler',
      isPopular: true,
      isNew: false)
  .._addBook(
      title: 'The Lathe of Heaven',
      authorName: 'Ursula K. Le Guin',
      isPopular: false,
      isNew: false);

/// A library that contains books and authors.
class LibraryApi implements LibraryRepository {
  final List<Book> _mockedBooks = <Book>[];
  final List<Author> _mockedAuthors = <Author>[];

  /// The books in the library.
  @override
  Future<List<Book>> get allBooks => Future.delayed(const Duration(seconds: 1), () => _mockedBooks);

  /// The authors in the library.
  @override
  Future<List<Author>> get allAuthors => Future.delayed(const Duration(seconds: 1), () => _mockedAuthors);

  /// Adds a book into the library.
  Future<void> addBook({
    required String title,
    required String authorName,
    required bool isPopular,
    required bool isNew,
  }) {
    return Future.delayed(const Duration(seconds: 1), () {
      _addBook(title: title, authorName: authorName, isPopular: isPopular, isNew: isNew);
    });
  }

  void _addBook({
    required String title,
    required String authorName,
    required bool isPopular,
    required bool isNew,
  }) {
    final Author author = _mockedAuthors.firstWhere(
      (Author author) => author.name == authorName,
      orElse: () {
        final Author value = Author(id: _mockedAuthors.length, name: authorName);
        _mockedAuthors.add(value);
        return value;
      },
    );

    final Book book = Book(
      id: _mockedBooks.length,
      title: title,
      isPopular: isPopular,
      isNew: isNew,
      author: author,
    );

    author.books.add(book);
    _mockedBooks.add(book);
  }
}
