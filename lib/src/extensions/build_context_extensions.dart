import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Currently not used, but this extension demonstrates how to access the current
/// [StatefulNavigationShellState] and [StatefulShellRoute] from a [BuildContext].
extension StatefulShellRouteContextHelper on BuildContext {
  StatefulNavigationShellState get navigationShell =>
      StatefulNavigationShell.of(this);

  StatefulShellRoute get statefulShellRoute => navigationShell.route;
}
