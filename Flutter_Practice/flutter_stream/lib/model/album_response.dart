class AlbumResponse {
  int userId;
  int id;
  String title;

  AlbumResponse({required this.userId, required this.id, required this.title});

  factory AlbumResponse.fromJson(Map<String, dynamic> json){
    return AlbumResponse(userId: json['userId'], id: json['id'], title: json['title']);
  }
}
