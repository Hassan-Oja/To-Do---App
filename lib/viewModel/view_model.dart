import 'package:notes_app/main.dart';

import '../models/task_model.dart';

class ViewModel {
  List<TaskModel> tasks = [
    TaskModel(
      title: "First title",
      description: "description",
      isCompleted: true,
      id: "123",
    ),
    TaskModel(
      title: "Second title",
      description: "second description",
      isCompleted: true,
      id: "19u4",
    ),
    TaskModel(
      title: "First title",
      description: "description",
      isCompleted: false,
      id: "123",
    ),
    TaskModel(
      title: "First title",
      description: "description",
      isCompleted: false,
      id: "123",
    ),
  ];

  // Methods
  // CRUD

  void addTask(TaskModel task) {
    // todo : modify the list in place
    tasks.add(task);

    // todo: Spread Operator to add new task to the list
    // tasks = [...tasks , task];
  }
  void updateCompleteTask(int index) {


  }
  void deleteTask(String task) {
    // todo : remove the task from the list
    for(int i = 0 ; i < tasks.length ; i++) {
      if(tasks[i].id == task) {
        tasks.removeAt(i);
        break;
      };
    };

  }
  void getTasks() {

  }
}
