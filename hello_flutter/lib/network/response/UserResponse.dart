import 'dart:convert';

List<UserResponse> userResponseFromJson(String str) => List<UserResponse>.from(json.decode(str).map((x) => UserResponse.fromJson(x)));

String userResponseToJson(List<UserResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserResponse {
    UserResponse({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    int userId;
    int id;
    String title;
    String body;

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
