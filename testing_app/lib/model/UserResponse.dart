class UserResponse {
  int id;
  String name;
  String userName;
  String email;
  Address address;
  String phone;
  String webSite;
  Company company;

  UserResponse(
      {required this.id,
      required this.name,
      required this.userName,
      required this.email,
      required this.address,
      required this.phone,
      required this.webSite,
      required this.company});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        id: json['id'],
        name: json['name'],
        userName: json['username'],
        email: json['email'],
        address: Address.fromJson(json['address']),
        phone: json['phone'],
        webSite: json['website'],
        company: Company.fromJson(json['company']));
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipCode;
  Geo geo;

  Address(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipCode,
      required this.geo});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        street: json['street'],
        suite: json['suite'],
        city: json['city'],
        zipCode: json['zipcode'],
        geo: Geo.fromJson(json['geo']));
  }
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({required this.name, required this.catchPhrase, required this.bs});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        name: json['name'], catchPhrase: json['catchPhrase'], bs: json['bs']);
  }
}

class Geo {
  String lat;
  String lng;

  Geo({required this.lat,required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json){
    return Geo(
      lat: json['lat'], 
      lng: json['lng']
    );
  }

}
