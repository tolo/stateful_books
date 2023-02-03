/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class Book extends _i1.SerializableEntity {
  Book({
    this.id,
    required this.title,
    required this.authorId,
    this.authorName,
    required this.isPopular,
    required this.isNew,
  });

  factory Book.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Book(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      title:
          serializationManager.deserialize<String>(jsonSerialization['title']),
      authorId:
          serializationManager.deserialize<int>(jsonSerialization['authorId']),
      authorName: serializationManager
          .deserialize<String?>(jsonSerialization['authorName']),
      isPopular: serializationManager
          .deserialize<bool>(jsonSerialization['isPopular']),
      isNew: serializationManager.deserialize<bool>(jsonSerialization['isNew']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  int authorId;

  String? authorName;

  bool isPopular;

  bool isNew;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authorId': authorId,
      'authorName': authorName,
      'isPopular': isPopular,
      'isNew': isNew,
    };
  }
}
