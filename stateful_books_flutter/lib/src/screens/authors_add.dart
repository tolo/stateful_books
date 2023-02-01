import 'package:flutter/material.dart';
import 'package:stateful_books/src/application_context.dart';
import 'package:stateful_books/src/widgets/widget_utils.dart';

class AddAuthorScreen extends StatefulWidget {
  const AddAuthorScreen({Key? key}) : super(key: key);

  @override
  State createState() => _AddAuthorScreenState();
}

class _AddAuthorScreenState extends State<AddAuthorScreen> with WidgetAdditions {

  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add author'),
      ),
      body: Center(child:
        Padding(padding: const EdgeInsets.all(32), child:
          Column(
            children: <Widget>[
              _input(context),
              const Padding(padding: EdgeInsets.all(16)),
              ElevatedButton(
                onPressed: () async {
                  final library = ApplicationContextProvider.of(context).library;
                  try {
                    await library.createAuthor(textController.text);
                    showSnack(scaffoldMessenger, 'Author added!');
                    navigator.pop();
                  } catch (e) {
                    showSnack(scaffoldMessenger, 'Error adding author: $e');
                  }
                },
                child: const Text('Add author'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: false,
      decoration: const InputDecoration(
        labelText: 'Author name',
        hintText: 'Enter the author name here...',
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      keyboardType: TextInputType.name,
    );
  }
}
