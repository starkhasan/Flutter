class Users {
  String name;
  String email;

  Users(this.name, this.email);

  Users.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}
