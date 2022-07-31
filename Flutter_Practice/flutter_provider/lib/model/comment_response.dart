class CommentResponse {
  int postId;
  int id;
  String name;
  String email;
  String body;

  CommentResponse({required this.postId,required this.id, required this.name, required this.email, required this.body});

  factory CommentResponse.fromJson(Map<String, dynamic> json){
    return CommentResponse(
      postId: json['postId'], 
      id: json['id'], 
      name: json['name'], 
      email: json['email'], 
      body: json['body']
    );
  }
}
