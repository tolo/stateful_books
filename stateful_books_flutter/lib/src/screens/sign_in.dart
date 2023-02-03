// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:stateful_books/src/application_context.dart';
import 'package:stateful_books/src/extensions/widget_extensions.dart';

/// Credential data class.
class Credentials {
  /// Creates a credential data object.
  Credentials(this.username, this.password);

  /// The username of the credentials.
  final String username;

  /// The password of the credentials.
  final String password;
}

/// The sign-in screen.
class SignInScreen extends StatefulWidget {
  /// Creates a sign-in screen.
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Card(
            elevation: 16,
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Sign in', style: Theme.of(context).textTheme.headlineMedium),
                  SignInWithEmailButton(caller: ApplicationContextProvider.of(context).sessionManager.caller)
                      .padding(top: 32),
                ],
              ).padding(all: 32),
            ),
          ),
        ),
      );
}
