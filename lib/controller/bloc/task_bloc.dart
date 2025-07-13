import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:todo_app/model/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    // add New task
    on<AddTaskEvent>(_addTask);

    // remove a task
    on<RemoveTaskEvent>(_removeTask);

    // toggle task
    on<ToggleEvent>(_toggleTask);
  }

  FutureOr<void> _addTask(AddTaskEvent event, Emitter<TaskState> emit) {
    int generatedId = state.taskList.isNotEmpty
        ? state.taskList.last.id + 1
        : 1; // Simple ID generation based on the last task in the list

    TaskModel model = TaskModel(
      id: generatedId,
      title: event.title,
      isCompleted: false,
    );
    // Using the spread operator (...) to add the old
    // list with the new model
    // and this is another way => List.from(state.taskList)..add(model)
    emit(TaskUpdate([...state.taskList, model]));
  }

  FutureOr<void> _removeTask(RemoveTaskEvent event, Emitter<TaskState> emit) {
    final List<TaskModel> newList = state.taskList
        .where((task) => task.id != event.id)
        .toList();

    emit(TaskUpdate(newList));
  }

  FutureOr<void> _toggleTask(ToggleEvent event, Emitter<TaskState> emit) {
    final List<TaskModel> newList = state.taskList
        .map(
          (task) => task.id == event.id
              ? task.copyWith(
                  id: task.id,
                  title: task.title,
                  isCompleted: !task.isCompleted,
                )
              : task,
        )
        .toList();
    emit(TaskUpdate(newList));
  }
}
