import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/task_item.dart';

class DoneTab extends StatefulWidget {
  const DoneTab({super.key});

  @override
  State<DoneTab> createState() => _ToDoTabState();
}

class _ToDoTabState extends State<DoneTab> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: viewModel.doneTasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          isDone: () {
            viewModel.taskStatus(index);
            setState(() {});
          },
          model: viewModel.doneTasks[index],
          removeTask: () {
            // todo : delete task with id
            viewModel.deleteTask(viewModel.doneTasks[index].id);

            setState(() {});
          },
        );
      },
    );
  }
}
