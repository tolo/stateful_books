import 'package:flutter/material.dart';

abstract class EntityList<T> extends StatelessWidget {
  /// Creates an [EntityList].
  const EntityList({
    required this.entities,
    this.onTap,
    super.key,
  });

  /// The list of entities to be displayed.
  final List<T> entities;

  /// Called when the user taps a book.
  final ValueChanged<T>? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entities.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(
          titleFor(entities[index]),
        ),
        subtitle: Text(
          subtitleFor(entities[index]),
        ),
        onTap: onTap != null ? () => onTap!(entities[index]) : null,
      ),
    );
  }

  /// The title to be displayed for the entity.
  String titleFor(T entity);

  /// The subtitle to be displayed for the entity.
  String subtitleFor(T entity);
}
