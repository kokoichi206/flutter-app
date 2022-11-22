import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Software Design",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SD_2022_12(),
      ),
    );
  }
}

class SD_2022_12 extends StatefulWidget {
  SD_2022_12({Key? key}) : super(key: key);

  @override
  State<SD_2022_12> createState() => _SD_2022_12State();
}

// State object!
class _SD_2022_12State extends State<SD_2022_12> {
  _SD_2022_12State();

  final List<String> greets = [
    "Hello",
    "Hello",
    "Hello",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  greets.add("Hello");
                });
              },
              child: const Text("Add Hello"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: greets.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      "${greets.elementAt(index)} - $index",
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SD_2022_11 extends StatelessWidget {
  const SD_2022_11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(labelText: "User ID"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
          ),
          ElevatedButton(
            onPressed: () => {},
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}
