// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:stateful_books/src/application_context.dart';

void main() async {
  // Need to call this as we are using Flutter bindings before runApp is called.
  WidgetsFlutterBinding.ensureInitialized();

  final applicationContext = await ApplicationContext.setupDefault();

  runApp(Bookstore(applicationContext: applicationContext));
}


/// The book store view.
class Bookstore extends StatelessWidget {
  /// Creates a [Bookstore].
  const Bookstore({required this.applicationContext, Key? key}) : super(key: key);

  final ApplicationContext applicationContext;

  @override
  Widget build(BuildContext context) =>
    ApplicationContextProvider(applicationContext: applicationContext,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: applicationContext.router,
      ),
    );
}

