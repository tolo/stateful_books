// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

/// Custom subclass of StatefulShellBranch that includes additional information
/// used when creating the AdaptiveNavigationScaffold.
class ScaffoldBranch extends StatefulShellBranch {
  ScaffoldBranch(
      {required super.rootLocation,
      required String title,
      required IconData icon})
      : adaptiveDestination = AdaptiveScaffoldDestination(
          title: title,
          icon: icon,
        );

  final AdaptiveScaffoldDestination adaptiveDestination;
}

/// The scaffold for the book store.
class BookstoreScaffold extends StatelessWidget {
  /// Creates a [BookstoreScaffold].
  const BookstoreScaffold({
    required this.child,
    required this.branches,
    Key? key,
  }) : super(key: key);

  /// The navigation branches that the menu items (destination) in this
  /// BookstoreScaffold should represent (using a AdaptiveNavigationScaffold).
  final List<ScaffoldBranch> branches;

  /// The scaffold body.
  final Widget child;

  void _goBranch(BuildContext context, int index) {
    final StatefulShellRouteState shellState = StatefulShellRoute.of(context);
    shellState.goBranch(index: index);
  }

  @override
  Widget build(BuildContext context) =>
    AdaptiveNavigationScaffold(
      selectedIndex: StatefulShellRoute.of(context).currentIndex,
      body: ClipRect(child: child),
      onDestinationSelected: (int idx) => _goBranch(context, idx),
      destinations: branches.map((e) => e.adaptiveDestination).toList(),
    );
}
