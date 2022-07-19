class WeatherResponse {
  Coords? coord;
  List<Weather>? weather;
  String? baseStation;
  Main? main;
  int? visibility;
  Wind? wind;
  Cloud? clouds;
  double? dt;
  Sys? sys;
  int? timeZone;
  int? id;
  String? name;
  int? cod;

  WeatherResponse({
    this.coord,
    this.weather,
    this.baseStation,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timeZone,
    this.id,
    this.name,
    this.cod
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json){
    return WeatherResponse(
      coord: Coords.fromJson(json['coord']), 
      weather: List<Weather>.from(json['weather'].map((item) => Weather.fromJson(item))), 
      baseStation: json['base'], 
      main: Main.fromJson(json['main']), 
      visibility: json['visibility'], 
      wind: Wind.fromJson(json['wind']), 
      clouds: Cloud.fromJson(json['clouds']), 
      dt: json['dt'], 
      sys: Sys.fromJson(json['sys']), 
      timeZone: json['timezone'], 
      id: json['id'], 
      name: json['name'], 
      cod: json['cod']
    );
  }
}

class Coords {
  double lat;
  double lng;

  Coords({
    required this.lat,
    required this.lng
  });

  factory Coords.fromJson(Map<String, dynamic> json){
    return Coords(lat: json['lat'], lng: json['lon']);
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this. icon
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      id: json['id'], 
      main: json['main'], 
      description: json['description'], 
      icon: json['icon']
    );
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel
  });

  factory Main.fromJson(Map<String, dynamic> json){
    return Main(
      temp: json['temp'], 
      feelsLike: json['feels_like'], 
      tempMin: json['temp_min'], 
      tempMax: json['temp_max'], 
      pressure: json['pressure'], 
      humidity: json['humidity'], 
      seaLevel: json['sea_level'], 
      grndLevel: json['grnd_level']
    );
  }
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust
  });

  factory Wind.fromJson(Map<String, dynamic> json){
    return Wind(
      speed: json['speed'], 
      deg: json['deg'], 
      gust: json['gust']
    );
  }

}

class Cloud {
  int all;

  Cloud({
    required this.all
  });

  factory Cloud.fromJson(Map<String, dynamic> json){
    return Cloud(all: json['all']);
  }
}

class Sys {
  int? type;
  int? id;
  String country;
  double sunrise;
  double sunset;

  Sys({
    this.type,
    this.id,
    required this.country,
    required this.sunrise,
    required this.sunset
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'], 
      id: json['id'],
      country: json['country'], 
      sunrise: json['sunrise'], 
      sunset: json['sunset']
    );
  }
}