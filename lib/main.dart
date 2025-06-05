import 'package:flutter/material.dart';
import '/models/services/todo.dart';
import '/models/services/tudo_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todos App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoService _todoService = TodoService();
  late Future<List<Todo>> _todos;

  @override
  void initState() {
    super.initState();
    _todos = _todoService.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: FutureBuilder<List<Todo>>(
        future: _todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final todos = snapshot.data!;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  leading: Icon(
                    todo.completed ? Icons.check_circle : Icons.circle_outlined,
                    color: todo.completed ? Colors.green : Colors.grey,
                  ),
                  title: Text(todo.title),
                  subtitle: Text('User ID: ${todo.userId}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
