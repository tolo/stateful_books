import 'package:flutter/material.dart';
import 'package:stateful_books/src/application_context.dart';
import 'package:stateful_books/src/widgets/future_widget.dart';
import 'package:stateful_books/src/widgets/widget_utils.dart';
import 'package:stateful_books_client/stateful_books_client.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> with WidgetAdditions {

  late final TextEditingController textController;

  Future<List<Author>>? _authors;
  Author? _selectedAuthor;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_authors == null) {
      final library = ApplicationContextProvider.of(context).library;
      _authors = library.allAuthors.then((value) {
        setState(() {
          _selectedAuthor = value.first;
        });
        return value;
      });
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add book'),
      ),
      body: FutureWidget<List<Author>>(
        future: _authors!,
        builder: _body,
      ),
    );
  }

  Widget _body(BuildContext context, List<Author> authors) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            _input(context),
            const Padding(padding: EdgeInsets.all(8)),
            Align(alignment: Alignment.centerLeft, child:
              _authorsDropDown(context, authors),
            ),
            const Padding(padding: EdgeInsets.all(16)),
            ElevatedButton(
              onPressed: _selectedAuthor == null ? null : _onAdd,
              child: const Text('Add book'),
            ),
          ],
        ),
      ),
    );
  }

  void _onAdd() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final library = ApplicationContextProvider.of(context).library;
    try {
      await library.createBook(textController.text, _selectedAuthor!);
      showSnack(scaffoldMessenger, 'Book added!');
      navigator.pop();
    } catch (e) {
      showSnack(scaffoldMessenger, 'Error adding book: $e');
    }
  }

  Widget _input(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: false,
      decoration: const InputDecoration(
        labelText: 'Book title',
        hintText: 'Enter the book title here...',
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      keyboardType: TextInputType.name,
    );
  }

  Widget _authorsDropDown(BuildContext context, List<Author> authors) {
    return DropdownButton<Author>(
      value: _selectedAuthor ?? authors.first,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (Author? value) {
        setState(() {
          _selectedAuthor = value!;
        });
      },
      items: authors.map<DropdownMenuItem<Author>>((Author value) {
        return DropdownMenuItem<Author>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
