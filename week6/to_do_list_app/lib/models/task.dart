class TodoTask {
  String title;
  bool isDone;

  TodoTask({required this.title, this.isDone = false});

  // For saving to shared_preferences
  Map<String, dynamic> toJson() => {
        'title': title,
        'isDone': isDone,
      };

  factory TodoTask.fromJson(Map<String, dynamic> json) => TodoTask(
        title: json['title'],
        isDone: json['isDone'],
      );
}
