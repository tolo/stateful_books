import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:stateful_books/src/auth.dart';
import 'package:stateful_books/src/data/library_api.dart';
import 'package:stateful_books/src/router.dart';
import 'package:stateful_books_client/stateful_books_client.dart';

class ApplicationContextProvider extends InheritedNotifier<ApplicationContext> {
  const ApplicationContextProvider({
    Key? key,
    required this.applicationContext,
    required Widget child,
  }) : super(key: key, child: child);

  final ApplicationContext applicationContext;

  static ApplicationContext of(BuildContext context) {
    final ApplicationContextProvider? result =
      context.dependOnInheritedWidgetOfExactType<ApplicationContextProvider>();
    assert(result != null, 'No ApplicationContextProvider found in context');
    return result!.applicationContext;
  }

  @override
  bool updateShouldNotify(ApplicationContextProvider oldWidget) {
    return applicationContext != oldWidget.applicationContext;
  }
}

class ApplicationContext extends ChangeNotifier {
  ApplicationContext._(this.client, this.auth, this.library, this.router);

  static Future<ApplicationContext> setupDefault() async {
    final client = Client('http://localhost:8080/', authenticationKeyManager: FlutterAuthenticationKeyManager(),)
      ..connectivityMonitor = FlutterConnectivityMonitor();

    final library = LibraryApi(client);
    final auth = BookstoreAuth(client);
    await auth.initialize();
    final router = AppRouter.buildRouter(auth);

    return ApplicationContext._(client, auth, library, router);
  }

  final Client client;
  SessionManager get sessionManager => auth.sessionManager;
  final BookstoreAuth auth;
  final LibraryApi library;
  final GoRouter router;

  void mustRebuild() {
    auth.notifyListeners();
  }
}