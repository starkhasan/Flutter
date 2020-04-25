import 'dart:convert';

PetsResponse petsResponseFromJson(String str) => PetsResponse.fromJson(json.decode(str));

String petsResponseToJson(PetsResponse data) => json.encode(data.toJson());

class PetsResponse {
    String message;
    int status;
    int tempPetCount;
    List<Pet> pets;

    PetsResponse({
        this.message,
        this.status,
        this.tempPetCount,
        this.pets,
    });

    factory PetsResponse.fromJson(Map<String, dynamic> json) => PetsResponse(
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
    });

    factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        name: json["name"],
        animalType: json["animal_type"],
        breed: json["breed"] == null ? null : json["breed"],
        birthday: json["birthday"] == null ? null : json["birthday"],
        subscriptionId: json["subscription_id"],
        paymentId: json["payment_id"],
        deviceId: json["device_id"],
        subscription: json["subscription"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "animal_type": animalType,
        "breed": breed == null ? null : breed,
        "birthday": birthday == null ? null : birthday,
        "subscription_id": subscriptionId,
        "payment_id": paymentId,
        "device_id": deviceId,
        "subscription": subscription,
    };
}
