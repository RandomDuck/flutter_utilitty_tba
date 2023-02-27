import 'package:flutter/material.dart';

class Todo {
  Todo({required this.task, required this.checked});
  final String task;
  bool checked;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChecked,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onTodoChecked;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return TextStyle(
      color: Colors.grey,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChecked(todo);
      },
      leading: Icon(Icons.hive),
      title: Text(todo.task, style: _getTextStyle(todo.checked)),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];

  void _todoChecked(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodo(String task) {
    setState(() {
      _todos.add(Todo(task: task, checked: false));
    });
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var todo in _todos)
          TodoItem(
            todo: todo,
            onTodoChecked: _todoChecked,
          ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: TextField(
                  controller: _textFieldController,
                  decoration:
                      const InputDecoration(hintText: 'Skriv din uppgift'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _addTodo(_textFieldController.text);
                },
                child: Text('Lägg till'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
