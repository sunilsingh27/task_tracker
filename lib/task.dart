
import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  bool isCompleted;

  Task({required this.title, required this.description, this.isCompleted = false});

  // Convert Task to a Map for storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Create Task from a Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
