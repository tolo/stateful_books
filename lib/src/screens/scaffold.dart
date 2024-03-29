// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom subclass of StatefulShellBranch that includes additional information
/// used when creating the AdaptiveNavigationScaffold.
class ScaffoldBranch extends StatefulShellBranch {
  ScaffoldBranch({
    required String title,
    required IconData icon,
    required super.routes,
  }) : adaptiveDestination = AdaptiveScaffoldDestination(
          title: title,
          icon: icon,
        );

  final AdaptiveScaffoldDestination adaptiveDestination;
}

/// The scaffold for the book store.
class BookstoreScaffold extends StatelessWidget {
  /// Creates a [BookstoreScaffold].
  const BookstoreScaffold({
    required this.navigationShell,
    Key? key,
  }) : super(key: key);

  /// The navigation branches that the menu items (destination) in this
  /// BookstoreScaffold should represent (using a AdaptiveNavigationScaffold).
  List<ScaffoldBranch> _branches(BuildContext context) =>
      navigationShell.route.branches
          .map((e) => e as ScaffoldBranch)
          .toList();

  /// The associated [StatefulNavigationShell], which will also be used as the body of the Scaffold
  final StatefulNavigationShell navigationShell;

  void _goBranch(BuildContext context, int index) =>
      navigationShell.goBranch(index);

  @override
  Widget build(BuildContext context) => AdaptiveNavigationScaffold(
        selectedIndex: navigationShell.currentIndex,
        body: ClipRect(child: navigationShell),
        onDestinationSelected: (int idx) => _goBranch(context, idx),
        destinations:
            _branches(context).map((e) => e.adaptiveDestination).toList(),
      );
}
