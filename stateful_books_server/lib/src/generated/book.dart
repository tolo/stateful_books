/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class Book extends _i1.TableRow {
  Book({
    int? id,
    required this.title,
    required this.authorId,
    this.authorName,
    required this.isPopular,
    required this.isNew,
  }) : super(id);

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

  static final t = BookTable();

  String title;

  int authorId;

  String? authorName;

  bool isPopular;

  bool isNew;

  @override
  String get tableName => 'book';
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

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'title': title,
      'authorId': authorId,
      'isPopular': isPopular,
      'isNew': isNew,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'title': title,
      'authorId': authorId,
      'authorName': authorName,
      'isPopular': isPopular,
      'isNew': isNew,
    };
  }

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'title':
        title = value;
        return;
      case 'authorId':
        authorId = value;
        return;
      case 'isPopular':
        isPopular = value;
        return;
      case 'isNew':
        isNew = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Book>> find(
    _i1.Session session, {
    BookExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Book>(
      where: where != null ? where(Book.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Book?> findSingleRow(
    _i1.Session session, {
    BookExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Book>(
      where: where != null ? where(Book.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Book?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Book>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required BookExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Book>(
      where: where(Book.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Book row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Book row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Book row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    BookExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Book>(
      where: where != null ? where(Book.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef BookExpressionBuilder = _i1.Expression Function(BookTable);

class BookTable extends _i1.Table {
  BookTable() : super(tableName: 'book');

  final id = _i1.ColumnInt('id');

  final title = _i1.ColumnString('title');

  final authorId = _i1.ColumnInt('authorId');

  final isPopular = _i1.ColumnBool('isPopular');

  final isNew = _i1.ColumnBool('isNew');

  @override
  List<_i1.Column> get columns => [
        id,
        title,
        authorId,
        isPopular,
        isNew,
      ];
}

@Deprecated('Use BookTable.t instead.')
BookTable tBook = BookTable();
