import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stateful_books/src/application_context.dart';
import 'package:stateful_books/src/auth.dart';
import 'package:stateful_books/src/screens/authors_add.dart';
import 'package:stateful_books/src/screens/books_add.dart';

import 'screens/author_details.dart';
import 'screens/authors.dart';
import 'screens/book_details.dart';
import 'screens/books.dart';
import 'screens/scaffold.dart';
import 'screens/settings.dart';
import 'screens/sign_in.dart';

class AppRouter {
  GoRouter buildRouter(ApplicationContext appContext) => GoRouter(
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
              child: const SignInScreen(),
            ),
      ),
      StatefulShellRoute(
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
                '/books/all/${state.params['bookId']}',
              ),
              GoRoute(
                path: '/books/:kind(new|all|popular)',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    FadeTransitionPage(
                      key: state.pageKey,
                      child: BooksScreen(state.params['kind']!),
                    ),
                routes: <GoRoute>[
                  GoRoute(
                    path: ':bookId([0-9]+)',
                    builder: (BuildContext context, GoRouterState state) {
                      final String bookId = state.params['bookId']!;
                      return BookDetailsScreen(appContext: appContext, bookId: int.tryParse(bookId));
                    },
                  ),
                  GoRoute(path: 'add', builder: (BuildContext context, GoRouterState state)
                    => const AddBookScreen()),
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
                    path: ':authorId([0-9]+)',
                    builder: (BuildContext context, GoRouterState state) {
                      final String authorId = state.params['authorId']!;
                      return AuthorDetailsScreen(appContext: appContext, authorId: int.tryParse(authorId));
                    },
                  ),
                  GoRoute(path: 'add', builder: (BuildContext context, GoRouterState state)
                    => const AddAuthorScreen()),
                ],
              ),
              GoRoute(
                path: '/author/:authorId',
                redirect: (BuildContext context, GoRouterState state) =>
                '/authors/${state.params['authorId']}',
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
        builder: (context, state, child) => BookstoreScaffold(child: child),
        pageBuilder: (context, state, child) =>
            FadeTransitionPage(key: state.pageKey, child: child),
      ),
    ],
    redirect: (context, state) => _guard(context, state, appContext.auth),
    refreshListenable: appContext.auth,
    debugLogDiagnostics: true,
  );

  static String? _guard(BuildContext context, GoRouterState state, BookstoreAuth auth) {
    final bool signedIn = auth.signedIn;
    final bool signingIn = state.subloc == '/signin';

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
    required LocalKey key,
    required Widget child,
  }) : super(
      key: key,
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
          FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
      child: child);

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}

