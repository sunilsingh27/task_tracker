// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'task_list.dart';

void main() {
  runApp(TaskTrackerApp());
}

class TaskTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Tracker App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background:Colors.blue[100])
      ),
      home: DefaultTextStyle(
        style: TextStyle(fontFamily: 'Montserrat'),
        child: TaskList(),
      ),
      builder: (context, child) {
        return StyledToast(
          locale: const Locale('en', 'US'),
          child: child!,
        );
      },
    );
  }
}
