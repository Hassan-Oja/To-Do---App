import 'package:flutter/material.dart';
import 'package:notes_app/viewModel/view_model.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

import '../main.dart';
import '../models/task_model.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
        backgroundColor: Colors.deepPurple,
        title: Text("Todo Screen"),
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 20),
        itemCount: viewModel.tasks.length,
        itemBuilder: (context, index) {
          return TaskItem(
            model: viewModel.tasks[index],
            removeTask: () {
              // todo : delete task with id
              viewModel.deleteTask(viewModel.tasks[index].id);

              setState(() {});
            },
          );
        },
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
        var mediaQuery = MediaQuery.of(context).viewInsets;
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;

        // print(mediaQuery.bottom);
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
                        prefixIcon: Icons.task_alt,
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
}
