import 'package:flutter/material.dart';
import '../../main.dart';
import '../../widgets/task_item.dart';

class DoneTab extends StatefulWidget {
  const DoneTab({super.key});

  @override
  State<DoneTab> createState() => _DoneTabState();
}

class _DoneTabState extends State<DoneTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: viewModel.doneTasks.length,
      itemBuilder: (context, index) {
        final task = viewModel.doneTasks[index];
        return TaskItem(
          isDone: () {
            viewModel.taskStatus(task);
            setState(() {});
          },
          model: task,
          removeTask: () {
            viewModel.deleteTask(task.id);
            setState(() {});
          },
        );
      },
    );
  }
}