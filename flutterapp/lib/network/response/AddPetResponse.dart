import 'dart:convert';

AddPetResponse addPetResponseFromJson(String str) => AddPetResponse.fromJson(json.decode(str));

String addPetResponseToJson(AddPetResponse data) => json.encode(data.toJson());

class AddPetResponse {
    String message;
    int status;
    String deviceId;
    int tempPetCount;

    AddPetResponse({
        this.message,
        this.status,
        this.deviceId,
        this.tempPetCount,
    });

    factory AddPetResponse.fromJson(Map<String, dynamic> json) => AddPetResponse(
        message: json["message"],
        status: json["status"],
        deviceId: json["device_id"],
        tempPetCount: json["temp_pet_count"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "device_id": deviceId,
        "temp_pet_count": tempPetCount,
    };
}
