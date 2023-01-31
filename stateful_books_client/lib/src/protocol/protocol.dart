/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'author.dart' as _i2;
import 'book.dart' as _i3;
import 'package:stateful_books_client/src/protocol/book.dart' as _i4;
import 'package:stateful_books_client/src/protocol/author.dart' as _i5;
export 'author.dart';
export 'book.dart';
export 'client.dart'; // ignore_for_file: equal_keys_in_map

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i2.Author) {
      return _i2.Author.fromJson(data, this) as T;
    }
    if (t == _i3.Book) {
      return _i3.Book.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Author?>()) {
      return (data != null ? _i2.Author.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.Book?>()) {
      return (data != null ? _i3.Book.fromJson(data, this) : null) as T;
    }
    if (t == List<_i4.Book>) {
      return (data as List).map((e) => deserialize<_i4.Book>(e)).toList()
          as dynamic;
    }
    if (t == List<_i5.Author>) {
      return (data as List).map((e) => deserialize<_i5.Author>(e)).toList()
          as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i2.Author) {
      return 'Author';
    }
    if (data is _i3.Book) {
      return 'Book';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Author') {
      return deserialize<_i2.Author>(data['data']);
    }
    if (data['className'] == 'Book') {
      return deserialize<_i3.Book>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
