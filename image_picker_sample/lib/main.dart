import 'package:flutter/material.dart';
import 'package:image_picker_sample/HTTPHelper.dart';
import 'package:image_picker_sample/pickup_screen.dart';
import 'package:image_picker_sample/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Center(
          child: Column(
            children: [
              const Spacer(),
              ElevatedButton(
                  onPressed: () async {
                    // Future<List<Map>> items = HTTPHelper().fetchItems();
                    List<Map<String, dynamic>> items =
                        await HTTPHelper().fetchItems();
                    print("===== items =====");
                    List<Post> posts = items.map((el) {
                      return Post.fromJson(el);
                    }).toList();
                    print("posts.length: ${posts.length}");
                    print("posts.length: ${posts}");
                  },
                  child: const Text("Get data")),
              const PickUpScreen(),
            ],
          ),
        ));
  }
}
