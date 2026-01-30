import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/models/task_model.dart';

class TaskItem extends StatelessWidget {

  final VoidCallback removeTask;
  final VoidCallback isDone;
  TaskModel model ;
   TaskItem({
    super.key,
    required this.model,
     required this.removeTask,
     required this.isDone
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.01),
      child: ListTile(
        title: Text(model.title,style: TextStyle(fontWeight: FontWeight.bold),),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(25),
            side: BorderSide(color: Colors.grey,width: 2)
        ),
        leading: InkWell(
          onTap: isDone,
          //     () {
          //   if(model.isCompleted) {
          //     model.isCompleted = false;
          //   } else {
          //     model.isCompleted = true;
          //   }
          // }
          child: Container(
            child: model.isCompleted! ? Icon(Icons.check,color: Colors.white,) : null,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: model.isCompleted! ? Colors.deepPurple : null,
              border: Border.all(
                  color: Colors.grey,
                  width: 2
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        subtitle: model.description != null ? Text(model.description!) : null,
        trailing: IconButton(
            onPressed: removeTask,
            //     (){
            //   // todo : delete task
            //   viewModel.deleteTask(model.id);
            //
            // },
            icon: Icon(Icons.remove)
        ),
        tileColor: Colors.white,

      ),
    );
  }
}