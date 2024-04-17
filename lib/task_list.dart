
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override


  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late List<Task> tasks = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskStrings = prefs.getStringList('tasks');
    if (taskStrings != null) {
      setState(() {
        tasks = taskStrings.map((e) => Task.fromMap(Map<String, dynamic>.from(e as Map))).toList();
      });
    } else {
      tasks = [];
    }
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = tasks.map((e) => e.toMap().toString()).toList();
    await prefs.setStringList('tasks', taskStrings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],

        title: Center(child: Text('Task Tracker',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25))),
      ),
      body: Expanded(
        flex: 5,
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            Task task = tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  setState(() {
                    task.isCompleted = value!;
                    _saveTasks();
                  });
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    tasks.removeAt(index);
                    _saveTasks();
                  });
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task',style: TextStyle(fontWeight: FontWeight.bold),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addTask();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addTask() {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title.isNotEmpty) {
      setState(() {
        tasks.add(Task(title: title, description: description));
        titleController.clear();
        descriptionController.clear();
        _saveTasks();
      });
    }
  }
}
