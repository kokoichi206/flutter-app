import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPHelper {
  // Future means "Result of an asynchronous operation"!
  Future<List<Map<String, dynamic>>> fetchItems() async {
    List<Map<String, dynamic>> items = [];

    // await wait for the completion!
    http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      String jsonString = response.body;
      List data = jsonDecode(jsonString);
      items = data.cast<Map<String, dynamic>>();
    }

    return items;
  }
}
