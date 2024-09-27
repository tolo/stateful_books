import 'package:go_router/go_router.dart';

extension GoRouterStateExtensions on GoRouterState {
  int pathParamAsInt(String param) =>
      int.tryParse(pathParameters[param] ?? '') ?? -1;
}
