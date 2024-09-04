import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:result_notifier/result_notifier.dart';

class Loader<T> extends WatcherWidget {
  const Loader({required this.listenable, required this.builder, super.key});

  final ValueListenable<Result<T>> listenable;
  final Widget Function(T data) builder;

  @override
  Widget build(covariant WatcherContext context) {
    final result = listenable.watch(ref);
    return switch (result) {
      Data(data: var d) => builder(d),
      Error(error: var e) => Text('Error: $e'),
      Loading() => const Center(child: CircularProgressIndicator()),
    };
  }
}
