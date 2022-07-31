class TodoResponse {
  int userId;
  int id;
  String title;
  bool completed;

  TodoResponse(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory TodoResponse.fromJson(Map<String, dynamic> json) {
    return TodoResponse(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed']);
  }
}
