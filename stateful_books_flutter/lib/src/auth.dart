// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:serverpod_auth_client/module.dart';

import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:stateful_books_client/stateful_books_client.dart';

/// A mock authentication service.
class BookstoreAuth extends ChangeNotifier {

  BookstoreAuth(Client client) : sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  final SessionManager sessionManager;

  /// Whether user has signed in.
  bool get signedIn => user != null;
  UserInfo? get user => sessionManager.signedInUser;
  bool get isAdmin => user?.scopeNames.contains('admin') ?? false;

  Future<void> initialize() async {
    // The session manager keeps track of the signed-in state of the user. You
    // can query it to see if the user is currently signed in and get information
    // about the user.
    await sessionManager.initialize();
    sessionManager.addListener(() {
      notifyListeners();
    });
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    await sessionManager.signOut();
    notifyListeners();
  }
}
