import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/main.dart';

import '../models/task_model.dart';

class ViewModel {
  List<TaskModel> tasks = [
    // TaskModel(
    //   title: "First title",
    //   description: "description",
    //   isCompleted: true,
    //   id: "123",
    // ),
    // TaskModel(
    //   title: "Second title",
    //   description: "second description",
    //   isCompleted: true,
    //   id: "19u4",
    // ),
    // TaskModel(
    //   title: "First title",
    //   description: "description",
    //   isCompleted: false,
    //   id: "1234",
    // ),
    // TaskModel(
    //   title: "First title",
    //   description: "description",
    //   isCompleted: false,
    //   id: "1235",
    // ),
  ];
  // List<TaskModel> doneTasks = [];
  // List<TaskModel> toDoTasks = [];

  List<TaskModel> get doneTasks => tasks.where((element) => element.isCompleted == true).toList();
  List<TaskModel> get toDoTasks => tasks.where((element) => element.isCompleted == false).toList();


  // Methods
  // CRUD

  void addTask(TaskModel task) async {
    // todo : modify the list in place
   tasks.add(task);
   final user = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("users").doc(user).collection("userTasks").doc(task.id).set({
     "title" : task.title,
     "description" : task.description,
     "isCompleted" : task.isCompleted
   });
    // todo: Spread Operator to add new task to the list
    // tasks = [...tasks , task];
  }
  void deleteTask(String task) {

    // todo : delete the task from the fire base
    final user = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("users").doc(user).collection("userTasks").doc(task).delete();

    // todo : remove the task from the list
    for(int i = 0 ; i < tasks.length ; i++) {
      if(tasks[i].id == task) {
        tasks.removeAt(i);
        break;
      };
    };

  }
  void taskStatus(int index) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final taskModel = tasks[index];

    taskModel.isCompleted = !taskModel.isCompleted!;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("userTasks")
        .doc(taskModel.id)
        .update({
      "isCompleted": taskModel.isCompleted,
    });
  }

  Future<void> getTasks()async{

    final userID = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance.collection("users").doc(userID).collection("userTasks").get();

    final models = snapshot.docs.map((doc) {
      final map = doc.data();
      return TaskModel(
          title: map["title"],
          description: map["description"],
          isCompleted: map["isCompleted"],
          id: doc.id
      );
    }).toList();
    // for(int i = 0 ; i < models.length ; i++){
    //   if(task.isCompleted == true){
    //     viewModel.doneTasks.add(models[i]);
    //   }else{
    //     viewModel.toDoTasks.add(models[i]);
    //   }
    // }
    tasks = models;

  }

}
