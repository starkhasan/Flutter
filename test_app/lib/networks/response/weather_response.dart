class WeatherResponse {
  int statusCode;
  String name;
  int id;
  int timeZone;
  int dt;
  int visibility;
  String base;
  Coordinate coordinate;
  List<Weather> weather;
  Main main;
  Wind wind;
  Clouds clouds;
  Sys sys;

  WeatherResponse({
    required this.statusCode,
    required this.name,
    required this.id,
    required this.timeZone,
    required this.dt,
    required this.visibility,
    required this.coordinate,
    required this.base,
    required this.clouds,
    required this.main,
    required this.sys,
    required this.weather,
    required this.wind
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      statusCode: json['cod'],
      name: json['name'],
      id: json['id'],
      timeZone: json['timezone'],
      dt: json['dt'],
      visibility: json['visibility'],
      coordinate: Coordinate.fromJson(json['coord']),
      base: json['base'],
      clouds: Clouds.fromJson(json['clouds']),
      main: Main.fromJson(json['main']),
      sys: Sys.fromJson(json['sys']),
      weather: List<Weather>.from(json['weather'].map((item) => Weather.fromJson(item))),
      wind: Wind.fromJson(json['wind']
    ));
  }
}

class Coordinate {
  double lat;
  double lon;

  Coordinate({required this.lat, required this.lon});

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(lat: json['lat'], lon: json['lon']);
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
    required this.icon
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
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
  int grandLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.grandLevel,
    required this.humidity,
    required this.seaLevel
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      grandLevel: json['grnd_level'],
      humidity: json['humidity'],
      seaLevel: json['sea_level']
    );
  }
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed'], deg: json['deg'], gust: json['gust']);
  }
}

class Clouds {
  int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all']);
  }
}

class Sys {
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  Sys({
    required this.type,
    required this.id,
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
