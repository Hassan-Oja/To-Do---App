import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/sign_in_screen.dart';
import 'package:notes_app/widgets/custom_text_field.dart';
import '../main.dart';
import '../models/task_model.dart';
import '../widgets/task_item.dart';
import 'Tabs/done_tab.dart';
import 'Tabs/to_do_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState(){

    // print(viewModel.tasks);
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await viewModel.getTasks();
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //todo : Show bottom sheet
            newTask(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ),
        appBar: AppBar(
          bottom:  TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            tabs: [
              Tab(text: 'To Do Tasks'),
              Tab(text: 'Done Tasks'),
            ],
          ),
          backgroundColor: Colors.deepPurple,
          title: Text("To Do App"),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Delete All Tasks"),
                      content: Text("Are you sure you want to delete all tasks?"),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                            onPressed: (){
                              deleteAllUserTasks();
                              viewModel.tasks.clear();
                              Navigator.pop(context);
                              setState(() {

                              });
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            )
                        )
                      ]
                    );

                  }
                )
                ,
                icon: Icon(Icons.delete)
            ),
            IconButton(
                onPressed: () async{
                  await logout(context);
                  print("========>logout");
                },
                icon: Icon(Icons.logout
                )
            ),
          ],
        ),
        body:  TabBarView(
          children: [
            ToDoTab(),
            DoneTab(),
          ],
        ),
      ),
    );
  }

  void newTask(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        var mediaQuery = MediaQuery
            .of(context)
            .viewInsets;
        var width = MediaQuery
            .of(context)
            .size
            .width;
        var height = MediaQuery
            .of(context)
            .size
            .height;

        return Padding(
          padding: EdgeInsets.only(bottom: mediaQuery.bottom),
          child: SizedBox(
            width: double.infinity,
            height: height * 0.4,
            child: Column(
              children: [
                SizedBox(height: height * 0.05),
                Text(
                  "Add Title",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: "Task Title",
                        prefixIcon: Icons.task_alt,
                        controller: _titleController,
                      ),
                      SizedBox(height: height * 0.005),
                      CustomTextField(
                        hintText: "Task description",
                        prefixIcon: Icons.description,
                        controller: _descriptionController,
                      ),
                      SizedBox(height: height * 0.05),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            var model = TaskModel(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              isCompleted: false,
                              id: UniqueKey().toString(),
                            );

                            // todo : Call addTask Method
                            viewModel.addTask(model);

                            // todo : refresh the screen
                            setState(() {});

                            // todo : Clear Text Controller
                            _titleController.clear();
                            _descriptionController.clear();

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.1,
                              vertical: height * 0.02,
                            ),
                          ),
                          child: Text("Add task"),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> deleteAllUserTasks() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final tasksRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('userTasks');

    final snapshot = await tasksRef.get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => SigninScreen()),
          (_) => false,
    );
  }


}
