import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TaskModel extends Equatable {
  final int id;
  final String title;
  final bool isCompleted;

  const TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  TaskModel copyWith({int? id, String? title, bool? isCompleted}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  TaskModel toJson() {
    return TaskModel(id: id, title: title, isCompleted: isCompleted);
  }

  @override
  List<Object?> get props => [id, title, isCompleted];
}
