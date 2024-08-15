// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:stateful_books/src/auth.dart';
import 'package:stateful_books/src/router.dart';

void main() => runApp(Bookstore());

/// The book store view.
class Bookstore extends StatelessWidget {
  /// Creates a [Bookstore].
  Bookstore({super.key});

  @override
  Widget build(BuildContext context) => BookstoreAuthScope(
        notifier: _auth,
        child: MaterialApp.router(
          routerConfig: _appRouter.configuration,
        ),
      );

  final BookstoreAuth _auth = BookstoreAuth();

  late final AppRouter _appRouter = AppRouter(auth: _auth);
}
