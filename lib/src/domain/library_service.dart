import 'package:flutter/foundation.dart';

import 'package:result_notifier/result_notifier.dart';

import 'package:stateful_books/src/data.dart';

typedef Books = List<Book>;
typedef Authors = List<Author>;

abstract interface class LibraryRepository {
  /// The books in the library.
  Future<List<Book>> get allBooks;

  /// The authors in the library.
  Future<List<Author>> get allAuthors;

  /// Adds a book into the library.
  Future<void> addBook({
    required String title,
    required String authorName,
    required bool isPopular,
    required bool isNew,
  });
}

class LibraryService {
  LibraryService(this.repository);

  final LibraryRepository repository;

  /// The list of popular books in the library.
  ValueListenable<Result<Books>> get allBooks => _allBooks;
  // Note: You can also use the type ResultListenable<Books> (or ResultNotifier<Books> of course) as return type.
  late final _allBooks = ResultNotifier<Books>.future((_) => repository.allBooks);

  /// The authors in the library.
  ValueListenable<Result<Authors>> get allAuthors => _allAuthors;
  late final _allAuthors = ResultNotifier<Authors>.future((_) => repository.allAuthors);

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
    return await repository.addBook(title: title, authorName: authorName, isPopular: isPopular, isNew: isNew)
      .then((_) {
      _allBooks.invalidate();
      _allAuthors.invalidate();
      return _allBooks.refreshAwait();
    });
  }
}
