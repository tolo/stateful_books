import 'package:flutter/material.dart';

typedef FutureWidgetBuilder<T> = Function(BuildContext context, T data);

class FutureWidget<T> extends StatelessWidget {
  const FutureWidget({required this.future, required this.builder, Key? key}) : super(key: key);

  final Future<T?> future;
  final FutureWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: future, builder: (context, snapshot) {
      if (snapshot.hasData) {
        return builder(context, snapshot.data as T);
      } else if (snapshot.hasError || snapshot.connectionState == ConnectionState.done) {
        return Scaffold(
            appBar: AppBar(title: const Text('Error occurred')),
            body: Center(child: Text('Error: ${snapshot.error}')),
        );
      } else {
        return Scaffold(
          appBar: AppBar(title: const Text('Loading')),
          body: const Center(child: CircularProgressIndicator()),
        );
      }
    });
  }
}
