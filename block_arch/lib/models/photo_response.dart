class PhotoResponse {
  int albumId;
  int id;
  String title;
  String url;
  String thumbNail;

  PhotoResponse({required this.albumId,required this.id,required this.title,required this.url,required this.thumbNail});

  factory PhotoResponse.fromJson(Map<String, dynamic> json){
    return PhotoResponse(
      albumId: json['albumId'], 
      id: json['id'], 
      title: json['title'], 
      url: json['url'], 
      thumbNail: json['thumbnailUrl']
    );
  }
}
