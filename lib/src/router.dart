import 'package:flutter/widgets.dart';

class AppRouter extends InheritedWidget {
  const AppRouter({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static AppRouter of(BuildContext context) {
    final AppRouter? result =
        context.dependOnInheritedWidgetOfExactType<AppRouter>();
    assert(result != null, 'No AppRouter found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppRouter oldWidget) {
    return false;
  }
}
