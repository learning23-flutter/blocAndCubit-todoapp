import 'package:bloc/bloc.dart';
import 'package:todo_app/model/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void addTask(String title) {
    final int generatedId = state.taskList.isNotEmpty
        ? state.taskList.last.id + 1
        : 1; // Simple ID generation based on the last task in the list
    TaskModel model = TaskModel(
      id: generatedId,
      title: '$title $generatedId',
      isCompleted: false,
    );
    // Using the spread operator (...) to add the old
    // list with the new model
    // and this is another way => List.from(state.taskList)..add(model)
    emit(TaskUpdate([...state.taskList, model]));
  }

  removeTask(int id) {
    // create a new list with the elements their id's not equal the given id
    List<TaskModel> newList = state.taskList
        .where((task) => task.id != id)
        .toList();
    emit(TaskUpdate(newList));
  }

  toggleTask(int id) {
    List<TaskModel> newList = state.taskList
        .map(
          (task) => task.id == id
              ? task.copyWith(isCompleted: !task.isCompleted)
              : task,
        )
        .toList();

    emit(TaskUpdate(newList));
  }
}
