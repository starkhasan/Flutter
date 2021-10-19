class FakeResponse {
  int id;
  String title;
  int userId;
  String body;

  FakeResponse(this.id, this.title, this.userId, this.body);

  FakeResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        userId = json['userId'],
        body = json['body'];
        
}
