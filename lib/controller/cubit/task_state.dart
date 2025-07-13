part of 'task_cubit.dart';

sealed class TaskState {
  const TaskState(this.taskList);
  final List<TaskModel> taskList;
}

final class TaskInitial extends TaskState {
  TaskInitial() : super([]);
}

final class TaskUpdate extends TaskState {
  TaskUpdate(super.taskList);
}
