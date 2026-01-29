class TaskModel {
  String id ;
  bool isCompleted;
  String title;
  String? description;

  TaskModel({
    required this.id,
    required this.isCompleted,
    required this.title,
    required this.description
  });

}