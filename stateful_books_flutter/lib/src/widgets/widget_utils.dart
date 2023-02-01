import 'package:flutter/material.dart';

mixin WidgetAdditions {
  void showSnack(ScaffoldMessengerState scaffoldMessengerState, String message) => scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(message))
  );
}
