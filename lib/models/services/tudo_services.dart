import 'package:http/http.dart' as http;
import 'dart:convert';

import '/models/services/todo.dart';

class TodoService {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/todos/';

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Todo.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
