import 'dart:convert';

GetLocationResponse getLocationResponseFromJson(String str) => GetLocationResponse.fromJson(json.decode(str));

String getLocationResponseToJson(GetLocationResponse data) => json.encode(data.toJson());

class GetLocationResponse {
    String message;
    int status;
    int tempPetCount;
    List<Pet> pets;

    GetLocationResponse({
        this.message,
        this.status,
        this.tempPetCount,
        this.pets,
    });

    factory GetLocationResponse.fromJson(Map<String, dynamic> json) => GetLocationResponse(
        message: json["message"],
        status: json["status"],
        tempPetCount: json["temp_pet_count"],
        pets: List<Pet>.from(json["pets"].map((x) => Pet.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "temp_pet_count": tempPetCount,
        "pets": List<dynamic>.from(pets.map((x) => x.toJson())),
    };
}

class Pet {
    int id;
    String name;
    String animalType;
    String breed;
    String birthday;
    String subscriptionId;
    String paymentId;
    String deviceId;
    bool subscription;
    LocationDetails locationDetails;

    Pet({
        this.id,
        this.name,
        this.animalType,
        this.breed,
        this.birthday,
        this.subscriptionId,
        this.paymentId,
        this.deviceId,
        this.subscription,
        this.locationDetails,
    });

    factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        name: json["name"],
        animalType: json["animal_type"],
        breed: json["breed"],
        birthday: json["birthday"] == null ? null : json["birthday"],
        subscriptionId: json["subscription_id"],
        paymentId: json["payment_id"],
        deviceId: json["device_id"],
        subscription: json["subscription"],
        locationDetails: LocationDetails.fromJson(json["location_details"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "animal_type": animalType,
        "breed": breed,
        "birthday": birthday == null ? null : birthday,
        "subscription_id": subscriptionId,
        "payment_id": paymentId,
        "device_id": deviceId,
        "subscription": subscription,
        "location_details": locationDetails.toJson(),
    };
}

class LocationDetails {
    double lat;
    double lon;
    String deviceDate;
    String speed;
    String direction;
    double degree;
    double battery;

    LocationDetails({
        this.lat,
        this.lon,
        this.deviceDate,
        this.speed,
        this.direction,
        this.degree,
        this.battery,
    });

    factory LocationDetails.fromJson(Map<String, dynamic> json) => LocationDetails(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        deviceDate: json["device_date"] == null ? null : json["device_date"],
        speed: json["speed"] == null ? null : json["speed"],
        direction: json["direction"] == null ? null : json["direction"],
        degree: json["degree"] == null ? null : json["degree"].toDouble(),
        battery: json["battery"] == null ? null : json["battery"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "device_date": deviceDate == null ? null : deviceDate,
        "speed": speed == null ? null : speed,
        "direction": direction == null ? null : direction,
        "degree": degree == null ? null : degree,
        "battery": battery == null ? null : battery,
    };
}
