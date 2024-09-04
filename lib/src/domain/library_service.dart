import 'package:flutter/foundation.dart';

import 'package:collection/collection.dart';
import 'package:result_notifier/result_notifier.dart';

import 'package:stateful_books/src/data/author.dart';
import 'package:stateful_books/src/data/book.dart';
import 'package:stateful_books/src/data/library.dart';

typedef Books = List<Book>;
typedef Authors = List<Author>;

/// Library service singleton.
final LibraryService libraryService = LibraryService(libraryApi);

class LibraryService {
  LibraryService(this.libraryApi);

  final LibraryApi libraryApi;

  /// The list of popular books in the library.
  ValueListenable<Result<Books>> get allBooks => _allBooks;
  // Note: You can also use the type ResultListenable<Books> (or ResultNotifier<Books> of course) as return type.
  late final _allBooks =
      ResultNotifier<Books>.future((_) => libraryApi.allBooks);

  /// The authors in the library.
  ValueListenable<Result<Authors>> get allAuthors => _allAuthors;
  late final _allAuthors =
      ResultNotifier<Authors>.future((_) => libraryApi.allAuthors);

  /// The list of popular books in the library.
  ValueListenable<Result<Books>> get popularBooks =>
      _allBooks.effect((_, books) => books.where((b) => b.isPopular).toList());

  /// The list of new books in the library.
  ValueListenable<Result<Books>> get newBooks =>
      _allBooks.effect((_, books) => books.where((b) => b.isNew).toList());

  Future<List<Book>> addBook({
    required String title,
    required String authorName,
    required bool isPopular,
    required bool isNew,
  }) async {
    return await libraryApi
        .addBook(
            title: title,
            authorName: authorName,
            isPopular: isPopular,
            isNew: isNew)
        .then((_) {
      _allBooks.invalidate();
      _allAuthors.invalidate();
      return _allBooks.refreshAwait();
    });
  }

  ValueListenable<Result<Book?>> getBookById(int id) {
    //return (await _allBooks.refreshAwait()).firstWhere((b) => b.id == id);
    return _allBooks.effect(
        (_, books) => books.firstWhereOrNull((b) => b.id == id),
        immediate: true);
    // _allBooks.refresh(alwaysTouch: true); // Ensure the books are loaded.
    // return effect;
  }

  ValueListenable<Result<Author?>> getAuthorById(int id) {
    return _allAuthors.effect(
        (_, authors) => authors.firstWhereOrNull((a) => a.id == id),
        immediate: true);
  }
}
