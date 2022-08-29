import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class EnvironmentVariables {
  static const apiKey = String.fromEnvironment('API_KEY');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translate App',
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _result;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _textEditController = TextEditingController();

  Future<void> _translate(String sentence) async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse('https://labs.goo.ne.jp/api/hiragana');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'app_id': EnvironmentVariables.apiKey,
      'sentence': sentence,
      'output_type': 'hiragana'
    });
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    final responseJson = json.decode(response.body) as Map<String, dynamic>;
    debugPrint(responseJson['converted']);
    setState(() {
      _result = responseJson['converted'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    if (result != null) {
      return _Result(sentence: result, onTapBack: (){
        setState(() {
          _result = null;
        });
      });
    } else if (_isLoading) {
      return const _Loading();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Translate App"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _textEditController,
                maxLength: 5,
                decoration: const InputDecoration(
                  hintText: 'Write something',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Should not be empty.';
                  }
                  return null;
                }
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  _translate(_textEditController.text);
                  final formState = _formKey.currentState!;
                  if (!formState.validate()) {
                    return;
                  };

                  debugPrint('text = ${_textEditController.text}');
                },
                child: const Text(
                  'Translate',
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
  }
}

class _Loading extends StatelessWidget {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Result extends StatelessWidget {
  const _Result({
    super.key,
    required this.sentence,
    required this.onTapBack,
  });

  final String sentence;
  final void Function() onTapBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(sentence),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onTapBack,
            child: const Text(
              'Retry',
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
