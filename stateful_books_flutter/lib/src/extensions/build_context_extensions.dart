import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension StatefulShellRouteContextHelper on BuildContext {
  StatefulShellRouteState get shellRouteState =>
      StatefulShellRouteState.of(this);
}
