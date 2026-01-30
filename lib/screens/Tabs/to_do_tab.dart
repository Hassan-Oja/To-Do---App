import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/task_item.dart';

class ToDoTab extends StatefulWidget {
  const ToDoTab({super.key});

  @override
  State<ToDoTab> createState() => _ToDoTabState();
}

class _ToDoTabState extends State<ToDoTab> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: viewModel.toDoTasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          isDone: () {
            viewModel.taskStatus(index);
            setState(() {});
          },
          model: viewModel.toDoTasks[index],
          removeTask: () {
            // todo : delete task with id
            viewModel.deleteTask(viewModel.toDoTasks[index].id);

            setState(() {});
          },
        );
      },
    );
  }
}
