class UserResponse {
  final int id;
  final String name;
  final String userName;
  final String email;
  final Address address;
  final String phone;
  final String webSite;
  final Company company;

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
  final String street;
  final String suite;
  final String city;
  final String zipCode;
  final Geo geo;

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

class Geo {
  final String lat;
  final String lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(lat: json['lat'], lng: json['lng']);
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({required this.name, required this.catchPhrase, required this.bs});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        name: json['name'], catchPhrase: json['catchPhrase'], bs: json['bs']);
  }
}
