import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:weather/models/weather_api_request.dart';
import '../components/weather_display.dart';
import '../models/reverse_geocode_api_request.dart';
import '../models/location.dart';
import '../models/weather_report.dart';
import '../screens/weather_detail_screen.dart';

class Home extends StatefulWidget {
  final title;
  static const routeName = '/';
  const Home({Key? key, required this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Position? position;
  Location? location;
  WeatherReport? report;

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  void getPosition() async {
    position = await _determinePosition();
    setState(() {});
    getLocation();
    getWeather();
  }

  void getLocation() async {
    if (position == null) {
      return;
    } else {
      location = await _determineLocation(position!);
      setState(() {});
    }
  }

  void getWeather() async {
    if (position == null) {
      return;
    } else {
      http.Response res = await http
          .get(Uri.parse(WeatherApiRequest(position: position!).apiCallUrl));
      report = WeatherReport.fromJSON(jsonDecode(res.body));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: location == null
              ? Text(widget.title)
              : Text(location.toString())),
      body: report == null
          ? Center(child: CircularProgressIndicator())
          : GestureDetector(
              onHorizontalDragEnd: (details) => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return WeatherDetailScreen(
                        report: report!,
                      );
                    }))
                  },
              child: WeatherDisplay(location: location!, report: report!)),
    );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    await Geolocator.openAppSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

// Determine the city and state from the position coordinates of the device
Future<Location> _determineLocation(Position position) async {
  var res = await http.get(Uri.parse(ReverseGeocodeApiRequest(
          latitude: position.latitude, longitude: position.longitude)
      .reqUrl));
  return Location.fromJson(jsonDecode(res.body));
}
