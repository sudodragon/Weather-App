import 'package:weather/models/pretty_date.dart';

class WeatherReport {
  final num? lat;
  final num? lon;
  final String? timezone;
  final int? timezoneOffset;
  final Current? current;
  final List<Minutely>? minutely;
  final List<Hourly>? hourly;
  final List<Daily>? daily;
  final List<dynamic>? alerts;

  const WeatherReport(
      {this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.minutely,
      this.hourly,
      this.daily,
      this.alerts});

  factory WeatherReport.fromJSON(Map<String, dynamic> json) {
    return WeatherReport(
        lat: json['lat'],
        lon: json['lon'],
        timezone: json['timezone'],
        timezoneOffset: json['timezone_offset'],
        current: Current.fromJSON(json['current']),
        minutely: getMinutelyListFromJson(json['minutely']),
        hourly: getHourlyListFromJson(json['hourly']),
        daily: getDailyListFromJson(json['daily']),
        alerts: json['alerts']);
  }

  String toString() {
    return '\nWEATHER REPORT:\n'
        'lat: $lat\n'
        'lon: $lon\n'
        'timezone: $timezone\n'
        'timezone_offset: $timezoneOffset\n'
        'current: ${current.toString()}\n'
        'minutely: ${minutely.toString()}\n'
        'hourly: ${hourly.toString()}\n'
        'daily: ${daily.toString()}\n'
        'alerts: $alerts';
  }
}

class Current {
  final int? _dt;
  final int? _sunrise;
  final int? _sunset;
  final num? _temp;
  final num? _feelsLike;
  final int? _pressure;
  final int? _humidity;
  final num? _dewPoint;
  final num? _uvi;
  final int? _clouds;
  final int? _visibility;
  final num? _windSpeed;
  final num? _windGust;
  final int? _windDeg;
  final Rain? _rain;
  final Snow? _snow;
  final List<Weather>? _weather;

  const Current(
      {dt,
      sunrise,
      sunset,
      temp,
      feelsLike,
      pressure,
      humidity,
      dewPoint,
      uvi,
      clouds,
      visibility,
      windSpeed,
      windGust,
      windDeg,
      rain,
      snow,
      weather})
      : _dt = dt,
        _sunrise = sunrise,
        _sunset = sunset,
        _temp = temp,
        _feelsLike = feelsLike,
        _pressure = pressure,
        _humidity = humidity,
        _dewPoint = dewPoint,
        _uvi = uvi,
        _clouds = clouds,
        _visibility = visibility,
        _windSpeed = windSpeed,
        _windGust = windGust,
        _windDeg = windDeg,
        _rain = rain,
        _snow = snow,
        _weather = weather;
  /*
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windGust,
      this.windDeg,
      this.rain,
      this.snow,
      this.weather});
*/
  factory Current.fromJSON(Map<String, dynamic> json) {
    return Current(
        dt: json['dt'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        temp: json['temp'],
        feelsLike: json['feels_like'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        dewPoint: json['dew_point'],
        uvi: json['uvi'],
        clouds: json['clouds'],
        visibility: json['visibility'],
        windSpeed: json['wind_speed'],
        windGust: json['wind_gust'],
        windDeg: json['wind_deg'],
        rain: json['rain'] == null ? null : Rain.fromJSON(json['rain']),
        snow: json['snow'] == null ? null : Snow.fromJSON(json['snow']),
        weather: getWeatherListFromJson(json['weather']));
  }

  String toString() {
    return '\n\tcurrent.current.dt: $_dt\n'
        '\tcurrent.sunrise: $_sunrise\n'
        '\tcurrent.sunset: $_sunset\n'
        '\tcurrent.temp: $_temp\n'
        '\tcurrent.feels_like: $_feelsLike\n'
        '\tcurrent.pressure: $_pressure\n'
        '\tcurrent.humidity: $_humidity\n'
        '\tcurrent.dew_point: $_dewPoint\n'
        '\tcurrent.uvi: $_uvi\n'
        '\tcurrent.clouds: $_clouds\n'
        '\tcurrent.visibility: $_visibility\n'
        '\tcurrent.wind_speed: $_windSpeed\n'
        '\tcurrent.wind_gust: $_windGust\n'
        '\tcurrent.wind_deg: $_windDeg\n'
        '\tcurrent.rain: $_rain\n'
        '\tcurrent.snow: $_snow\n'
        '\tcurrent.weather: $_weather';
  }

  String get dt =>
      PrettyDate(dateTime: DateTime.fromMillisecondsSinceEpoch(_dt! * 1000))
          .prettyDate;
  String get sunrise => _formatTime(_sunrise!);
  String get sunset => _formatTime(_sunset!);
  String get temp => '${_temp!.round()} \u2109';  // \u2190 is deg Fahrenheit
  String get feelsLike => '${_feelsLike!.round()} \u2109';
  String get pressure => '$_pressure hPa';
  String get humidity => '$_humidity %';
  String get dewPoint => '${_dewPoint!.round()} \u2109'; 
  String get uvi => '$_uvi';
  String get clouds => '$_clouds %';
  String get visibility => '$_visibility meters';
  String get windSpeed => '$_windSpeed mph';
  String? get windGust => _windGust == null ? null : '$_windGust mph';
  String get windDeg => '$_windDeg \u00B0';
  get rain => _rain;
  get snow => _snow;
  get weather => _weather;

  String _formatTime(int _secondsSinceEpoch) {
    return PrettyDate(
            dateTime:
                DateTime.fromMillisecondsSinceEpoch(_secondsSinceEpoch * 1000))
        .prettyTime;
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather.fromJSON(Map<String, dynamic> json)
      : this.id = json['id'],
        this.main = json['main'],
        this.description = json['description'],
        this.icon = json['icon'];

  String toString() {
    return '\n\t\tweather.id: $id\n'
        '\t\tweather.main: $main\n'
        '\t\tweather.description: $description\n'
        '\t\tweather.icon: $icon';
  }
}

class Rain {
  num? lh;
  Rain({this.lh});
  Rain.nullOb() : this.lh = null;

  factory Rain.fromJSON(dynamic json) {
    if (json == null) {
      return Rain.nullOb();
    }
    return Rain(lh: json['lh']);
  }

  String toString() {
    return '\n\t\train.lh: $lh';
  }
}

class Snow {
  num? lh;
  Snow({this.lh});
  Snow.nullOb() : this.lh = null;

  factory Snow.fromJSON(Map<String, dynamic> json) {
    if (json['lh'] == null) {
      return Snow.nullOb();
    }
    return Snow(lh: json['lh']);
  }

  String toString() {
    return '\n\t\tsnow.lh: $lh';
  }
}

class Minutely {
  final int dt;
  final num precipitation;

  Minutely.fromJSON(Map<String, dynamic> json)
      : this.dt = json['dt'],
        this.precipitation = json['precipitation'];

  String toString() {
    return '\n'
        '\t\minutely.dt: $dt\n'
        '\tminutely.precipitation: $precipitation';
  }
}

class Hourly {
  int? dt;
  num? temp;
  num? feelsLike;
  int? pressure;
  int? humidity;
  num? dewPoint;
  num? uvi;
  int? clouds;
  int? visibility;
  num? windSpeed;
  num? windGust;
  //TODO: put in pull request for typo in page https://openweathermap.org/api/one-call-api#multi
  int? windDeg;
  List<Weather>? weather;
  num? pop;
  Rain? rain;
  Snow? snow;

  Hourly(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windGust,
      this.windDeg,
      this.weather,
      this.pop,
      this.rain,
      this.snow});

  factory Hourly.fromJSON(Map<String, dynamic> json) {
    return Hourly(
        dt: json['dt'] ?? null,
        temp: json['temp'] ?? null,
        feelsLike: json['feels_like'] ?? null,
        pressure: json['pressure'] ?? null,
        humidity: json['humidity'] ?? null,
        dewPoint: json['dew_point'] ?? null,
        uvi: json['uvi'] ?? null,
        clouds: json['clouds'] ?? null,
        visibility: json['visibility'] ?? null,
        windSpeed: json['wind_speed'] ?? null,
        windGust: json['wind_gust'] ?? null,
        windDeg: json['wind_deg'] ?? null,
        weather: getWeatherListFromJson(json['weather']),
        pop: json['pop'] ?? null,
        rain: json['rain'] == null ? null : Rain.fromJSON(json['rain']),
        snow: json['snow'] == null ? null : Snow.fromJSON(json['snow']));
  }

  String toString() {
    return '\n'
        '\thourly.dt: $dt\n'
        '\thourly.temp: $temp\n'
        '\thourly.feels_like: $feelsLike\n'
        '\thourly.pressure: $pressure\n'
        '\thourly.humidity: $humidity\n'
        '\thourly.dew_point: $dewPoint\n'
        '\thourly.uvi: $uvi\n'
        '\thourly.clouds: $clouds\n'
        '\thourly.visibility: $visibility\n'
        '\thourly.wind_speed: $windSpeed\n'
        '\thourly.wind_gust: $windGust\n'
        '\thourly.wind_deg: $windDeg\n'
        '\thourly.weather: $weather\n'
        '\thourly.pop: $pop\n'
        '\thourly.rain: $rain\n'
        '\thourly.snow: $snow\n';
  }
}

class Daily {
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  num? moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  int? pressure;
  int? humidity;
  num? dewPoint;
  num? windSpeed;
  num? windGust;
  int? windDeg;
  int? clouds;
  num? pop;
  num? rainVolume;
  num? snowVolume;
  num? uvi;
  List<Weather>? weather;

  Daily(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windGust,
      this.windDeg,
      this.clouds,
      this.pop,
      this.rainVolume,
      this.snowVolume,
      this.uvi,
      this.weather});

  factory Daily.fromJSON(Map<String, dynamic> json) {
    return Daily(
      dt: json['dt'] ?? null,
      temp: Temp.fromJSON(json['temp']),
      sunrise: json['sunrise'] ?? null,
      sunset: json['sunset'] ?? null,
      moonrise: json['moonrise'] ?? null,
      moonset: json['moonset'] ?? null,
      moonPhase: json['moonPhase'] ?? null,
      feelsLike: FeelsLike.fromJSON(json['feels_like']),
      pressure: json['pressure'] ?? null,
      humidity: json['humidity'] ?? null,
      dewPoint: json['dew_point'] ?? null,
      windSpeed: json['wind_speed'] ?? null,
      windGust: json['wind_gust'] ?? null,
      windDeg: json['wind_deg'] ?? null,
      clouds: json['clouds'] ?? null,
      pop: json['pop'] ?? null,
      rainVolume: json['rain'] ?? null,
      snowVolume: json['snow'] ?? null,
      uvi: json['uvi'] ?? null,
      weather: getWeatherListFromJson(json['weather']),
    );
  }

  String toString() {
    return '\n'
        '\tdaily.dt: $dt\n'
        '\tdaily.sunrise: $sunrise\n'
        '\tdaily.sunset: $sunset\n'
        '\tdaily.moonrise: $moonrise\n'
        '\tdaily.moonset: $moonset\n'
        '\tdaily.moonPhase: $moonPhase\n'
        '\tdaily.temp: $temp\n'
        '\tdaily.feels_like: $feelsLike\n'
        '\tdaily.pressure: $pressure\n'
        '\tdaily.humidity: $humidity\n'
        '\tdaily.dew_point: $dewPoint\n'
        '\tdaily.wind_speed: $windSpeed\n'
        '\tdaily.wind_gust: $windGust\n'
        '\tdaily.wind_deg: $windDeg\n'
        '\tdaily.clouds: $clouds\n'
        '\tdaily.pop: $pop\n'
        '\tdaily.rainVolume: $rainVolume\n'
        '\tdaily.snowVolume: $snowVolume\n'
        '\tdaily.uvi: $uvi\n'
        '\tdaily.weather: $weather\n';
  }
}

class Temp {
  num? day;
  num? min;
  num? max;
  num? night;
  num? eve;
  num? morn;

  Temp.fromJSON(Map<String, dynamic> json)
      : this.day = json['day'],
        this.min = json['min'],
        this.max = json['max'],
        this.night = json['night'],
        this.eve = json['eve'],
        this.morn = json['morn'];

  String toString() {
    return '\n'
        '\t\ttemp.day: $day\n'
        '\t\ttemp.min: $min\n'
        '\t\ttemp.max: $max\n'
        '\t\ttemp.night: $night\n'
        '\t\ttemp.eve: $eve\n'
        '\t\ttemp.morn: $morn\n';
  }
}

class FeelsLike {
  num? day;
  num? night;
  num? eve;
  num? morn;

  FeelsLike.fromJSON(Map<String, dynamic> json)
      : this.day = json['day'],
        this.night = json['night'],
        this.eve = json['eve'],
        this.morn = json['morn'];

  String toString() {
    return '\n'
        '\t\tfeelsLike.day: $day\n'
        '\t\tfeelsLike.night: $night\n'
        '\t\tfeelsLike.eve: $eve\n'
        '\t\tfeelsLike.morn: $morn\n';
  }
}

class Alerts {
  final String senderName;
  final String event;
  final int start;
  final int end;
  final String description;
  final List<String> tags;

  Alerts.fromJSON(Map<String, dynamic> json)
      : this.senderName = json['sender_name'],
        this.event = json['event'],
        this.start = json['start'],
        this.end = json['end'],
        this.description = json['description'],
        this.tags = json['tags'];

  String toString() {
    return '\n'
        '\talerts.senderName: $senderName\n'
        '\talerts.event: $event\n'
        '\talerts.start: $start\n'
        '\talerts.end: $end\n'
        '\talerts.description: $description\n'
        '\talerts.tags: $tags\n';
  }
}

List<Weather> getWeatherListFromJson(List<dynamic> json) {
  List<Weather> weatherList = [];
  for (var item in json) {
    weatherList.add(Weather.fromJSON(item));
  }
  return weatherList;
}

List<Daily> getDailyListFromJson(List<dynamic> json) {
  List<Daily> list = [];
  for (var item in json) {
    list.add(Daily.fromJSON(item));
  }
  return list;
}

List<Hourly> getHourlyListFromJson(List<dynamic> json) {
  List<Hourly> list = [];
  for (var item in json) {
    list.add(Hourly.fromJSON(item));
  }
  return list;
}

List<Minutely> getMinutelyListFromJson(List<dynamic> json) {
  List<Minutely> list = [];
  for (var item in json) {
    list.add(Minutely.fromJSON(item));
  }
  return list;
}
