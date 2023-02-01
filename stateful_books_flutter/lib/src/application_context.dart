import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:stateful_books/src/auth.dart';
import 'package:stateful_books/src/data/library_api.dart';
import 'package:stateful_books/src/router.dart';
import 'package:stateful_books_client/stateful_books_client.dart';

class ApplicationContextProvider extends InheritedNotifier<ApplicationContext> {
  ApplicationContextProvider({
    Key? key,
    ApplicationContext? applicationContext,
    required Widget child,
  }) : applicationContext = applicationContext ?? ApplicationContext(),
       super(key: key, child: child);

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
  ApplicationContext() {
    client = Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor();
    library = LibraryApi(client);
    auth = BookstoreAuth();
    router = AppRouter.buildRouter(auth);
  }

  late final BookstoreAuth auth;
  late final LibraryApi library;
  late final Client client;
  late final GoRouter router;
}