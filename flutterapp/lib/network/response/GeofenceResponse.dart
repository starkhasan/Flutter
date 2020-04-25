import 'dart:convert';

GeofenceResponse geofenceResponseFromJson(String str) => GeofenceResponse.fromJson(json.decode(str));

String geofenceResponseToJson(GeofenceResponse data) => json.encode(data.toJson());

class GeofenceResponse {
    String message;
    int status;
    List<Geofance> geofances;

    GeofenceResponse({
        this.message,
        this.status,
        this.geofances,
    });

    factory GeofenceResponse.fromJson(Map<String, dynamic> json) => GeofenceResponse(
        message: json["message"],
        status: json["status"],
        geofances: List<Geofance>.from(json["geofances"].map((x) => Geofance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "geofances": List<dynamic>.from(geofances.map((x) => x.toJson())),
    };
}

class Geofance {
    int id;
    String name;
    List<Polygon> polygon;
    String deviceId;

    Geofance({
        this.id,
        this.name,
        this.polygon,
        this.deviceId,
    });

    factory Geofance.fromJson(Map<String, dynamic> json) => Geofance(
        id: json["id"],
        name: json["name"],
        polygon: List<Polygon>.from(json["polygon"].map((x) => Polygon.fromJson(x))),
        deviceId: json["device_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "polygon": List<dynamic>.from(polygon.map((x) => x.toJson())),
        "device_id": deviceId,
    };
}

class Polygon {
    double latitude;
    double longitude;

    Polygon({
        this.latitude,
        this.longitude,
    });

    factory Polygon.fromJson(Map<String, dynamic> json) => Polygon(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
