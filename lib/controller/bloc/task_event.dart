part of 'task_bloc.dart';

sealed class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;
  AddTaskEvent(this.title);
}

class RemoveTaskEvent extends TaskEvent {
  final int id;
  RemoveTaskEvent(this.id);
}

class ToggleEvent extends TaskEvent {
  final int id;
  ToggleEvent(this.id);
}
