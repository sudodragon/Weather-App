import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApiRequest {
  final String? weatherKey = dotenv.env['WEATHER_KEY'];
  //TODO: get lang and units from user prefs
  final String units = 'imperial'; // standard, imperial, or metric
  final String lang = 'en';
  final Position position;

  WeatherApiRequest({required this.position});

  String get apiCallUrl => 'https://api.openweathermap.org/data/2.5/onecall?'
      'lat=${position.latitude}'
      '&lon=${position.longitude}'
      '&units=$units'
      '&lang=$lang'
      '&appid=$weatherKey';
}

