import 'package:flutter/material.dart';
import 'package:stateful_books/src/application_context.dart';

abstract class StatelessWidgetBase extends StatelessWidget {
  const StatelessWidgetBase({required this.appContext, Key? key}) : super(key: key);

  final ApplicationContext appContext;
}
