import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReverseGeocodeApiRequest {
  final String? _mapApiKey = dotenv.env['LOCATION_KEY'];
  final double latitude;
  final double longitude;

  ReverseGeocodeApiRequest({required this.latitude, required this.longitude});

  String get reqUrl => 'http://open.mapquestapi.com/geocoding/v1/reverse?'
  'key=$_mapApiKey'
  '&location=${this.latitude},${this.longitude}';
}
