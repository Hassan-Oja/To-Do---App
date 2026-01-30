class TaskModel {
  String id;
  bool? isCompleted;
  String title;
  String? description;

  TaskModel({
    required this.id,
    this.isCompleted = false,
    required this.title,
    required this.description,
  });
}
