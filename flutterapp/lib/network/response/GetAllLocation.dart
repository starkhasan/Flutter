import 'dart:convert';

GetAllLocation getAllLocationFromJson(String str) => GetAllLocation.fromJson(json.decode(str));

String getAllLocationToJson(GetAllLocation data) => json.encode(data.toJson());

class GetAllLocation {
    List<DeviceDetail> deviceDetails;
    int status;
    String message;

    GetAllLocation({
        this.deviceDetails,
        this.status,
        this.message,
    });

    factory GetAllLocation.fromJson(Map<String, dynamic> json) => GetAllLocation(
        deviceDetails: List<DeviceDetail>.from(json["device_details"].map((x) => DeviceDetail.fromJson(x))),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "device_details": List<dynamic>.from(deviceDetails.map((x) => x.toJson())),
        "status": status,
        "message": message,
    };
}

class DeviceDetail {
    double lat;
    double lon;
    String datetime;
    double degree;
    double battery;

    DeviceDetail({
        this.lat,
        this.lon,
        this.datetime,
        this.degree,
        this.battery,
    });

    factory DeviceDetail.fromJson(Map<String, dynamic> json) => DeviceDetail(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        datetime: json["datetime"],
        degree: json["degree"].toDouble(),
        battery: json["battery"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "datetime": datetime,
        "degree": degree,
        "battery": battery,
    };
}
