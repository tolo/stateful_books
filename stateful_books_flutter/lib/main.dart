// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:stateful_books/src/application_context.dart';

import 'src/auth.dart';

final _applicationContext = ApplicationContext();

void main() => runApp(const Bookstore());

/// The book store view.
class Bookstore extends StatelessWidget {
  /// Creates a [Bookstore].
  const Bookstore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    ApplicationContextProvider(applicationContext: _applicationContext, child:
      BookstoreAuthScope(
        notifier: _applicationContext.auth,
        child: MaterialApp.router(
          routerConfig: _applicationContext.router,
        ),
      ),
    );
}

