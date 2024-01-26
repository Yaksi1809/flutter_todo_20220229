import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '..TO DO LIST..',
      home: TodoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('.. - TO DO LIST - ..'),
        backgroundColor: const Color.fromARGB(255, 238, 173, 248),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              tasks[index].task,
              style: TextStyle(
                decoration:
                    tasks[index].checked ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: tasks[index].checked,
                  onChanged: (bool? value) {
                    setState(() {
                      tasks[index].checked = value ?? false;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _editTask(context, index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteTask(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        tooltip: 'Agrega una nueva tarea',
        child: const Icon(Icons.add),
      ),
    );
  }


  void _addTask(BuildContext context) {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agrega una tarea nueva.'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Ingresa la tarea.'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(taskController.text, false));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Agregar.'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar.'),
            ),
          ],
        );
      },
    );
  }

  
  void _editTask(BuildContext context, int index) {
    TextEditingController taskController =
        TextEditingController(text: tasks[index].task);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar la tarea.'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Editar la tarea.'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index].task = taskController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Guardar.'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar.'),
            ),
          ],
        );
      },
    );
  }


  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }
}

class Task {
  String task;
  bool checked;

  Task(this.task, this.checked);
}