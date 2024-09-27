import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stateful_books/src/extensions/go_router_state_extensions.dart';

import 'auth.dart';
import 'data/book.dart';
import 'screens/author_details.dart';
import 'screens/authors.dart';
import 'screens/book_details.dart';
import 'screens/books.dart';
import 'screens/scaffold.dart';
import 'screens/settings.dart';
import 'screens/sign_in.dart';

/// AppRouter is responsible for providing the router configuration for the app.
class AppRouter {
  /// Creates an AppRouter.
  AppRouter({required BookstoreAuth auth}) : _auth = auth;

  final BookstoreAuth _auth;

  /// The router configuration for the app.
  late final RouterConfig<Object> configuration = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        redirect: (_, __) => '/books',
      ),
      GoRoute(
        path: '/signin',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            FadeTransitionPage(
          key: state.pageKey,
          child: SignInScreen(
            onSignIn: (Credentials credentials) {
              BookstoreAuthScope.of(context)
                  .signIn(credentials.username, credentials.password);
            },
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        branches: [
          /// The custom branch class ScaffoldBranch includes additional information
          /// (title and icon) to make it possible to setup the AdaptiveNavigationScaffold
          /// directly from the branches.
          ScaffoldBranch(
            title: 'Books',
            icon: Icons.book,
            routes: [
              GoRoute(
                path: '/books',
                redirect: (_, __) => '/books/popular',
              ),
              GoRoute(
                path: '/book/:bookId',
                redirect: (BuildContext context, GoRouterState state) =>
                    '/books/all/${state.pathParameters['bookId']}',
              ),
              GoRoute(
                path: '/books/:kind(new|all|popular)',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    FadeTransitionPage(
                  key: state.pageKey,
                  child: BooksScreen(state.pathParameters['kind']!),
                ),
                routes: <GoRoute>[
                  GoRoute(
                    path: ':bookId',
                    builder: (BuildContext context, GoRouterState state) {
                      final int bookId = state.pathParamAsInt('bookId');
                      final Book? book = state.extra as Book?;
                      return BookDetailsScreen.loadBook(bookId, book);
                    },
                  ),
                ],
              ),
            ],
          ),
          ScaffoldBranch(
            title: 'Authors',
            icon: Icons.person,
            routes: [
              GoRoute(
                path: '/authors',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    FadeTransitionPage(
                  key: state.pageKey,
                  child: const AuthorsScreen(),
                ),
                routes: <GoRoute>[
                  GoRoute(
                    path: ':authorId',
                    builder: (BuildContext context, GoRouterState state) {
                      final int authorId = state.pathParamAsInt('authorId');
                      return AuthorDetailsScreen.loadAuthor(authorId);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/author/:authorId',
                redirect: (BuildContext context, GoRouterState state) =>
                    '/authors/${state.pathParameters['authorId']}',
              ),
            ],
          ),
          ScaffoldBranch(
            title: 'Settings',
            icon: Icons.settings,
            routes: [
              GoRoute(
                path: '/settings',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    FadeTransitionPage(
                  key: state.pageKey,
                  child: const SettingsScreen(),
                ),
              ),
            ],
          ),
        ],
        pageBuilder: (context, state, navigationShell) => FadeTransitionPage(
          key: state.pageKey,
          child: BookstoreScaffold(navigationShell: navigationShell),
        ),
      ),
    ],
    redirect: _guard,
    refreshListenable: _auth,
    debugLogDiagnostics: true,
  );

  String? _guard(BuildContext context, GoRouterState state) {
    final bool signedIn = _auth.signedIn;
    final bool signingIn = state.matchedLocation == '/signin';

    // Go to /signin if the user is not signed in
    if (!signedIn && !signingIn) {
      return '/signin';
    }
    // Go to /books if the user is signed in and tries to go to /signin.
    else if (signedIn && signingIn) {
      return '/books';
    }

    // no redirect
    return null;
  }
}

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ));

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
