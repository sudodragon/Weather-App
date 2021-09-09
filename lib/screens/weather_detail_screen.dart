import 'package:flutter/material.dart';
import '../components/uvi_text.dart';
import '../models/weather_report.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherReport report;
  static const routeName = 'detail';
  static const appBarTitle = 'Weather Report Details';
  const WeatherDetailScreen({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Current curr = report.current!;
    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: Column(
          children: [
            detailItem(Icons.date_range, 'Current', curr.dt),
            detailItem(Icons.wb_sunny, 'Sunrise', curr.sunrise),
            detailItem(Icons.mode_night, 'Sunset', curr.sunset),
            detailItem(Icons.thermostat, 'Temperature', curr.temp),
            detailItem(Icons.touch_app, 'Feels like', curr.feelsLike),
            detailItem(
                Icons.align_vertical_bottom_rounded, 'Pressure', curr.pressure),
            detailItem(Icons.water, 'Humidity', curr.humidity),
            detailItem(Icons.water, 'Dew Point', curr.dewPoint),
            detailItem(Icons.wb_sunny, 'UV Index', curr.uvi),
            detailItem(Icons.cloud, 'Clouds', curr.clouds),
            detailItem(Icons.visibility, 'Visibility', curr.visibility),
            detailItem(Icons.air, 'Wind Speed', curr.windSpeed),
            detailItem(Icons.air, 'Wind Degrees', curr.windDeg),
            if (curr.rain != null)
              detailItem(Icons.water, 'Rain', curr.rain),
            if (curr.snow != null) detailItem(Icons.ac_unit, 'Snow', curr.snow),
            detailItem(Icons.air, 'Weather', curr.weather[0].description),
          ],
        ));
  }
}

Widget detailItem(IconData icon, String text, String data) {
  if (text == 'UV Index') {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: Text(text),
          )
        ]),
        UVItext(uvi: double.parse(data))
      ]),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: Text(text),
          )
        ]),
        Text(data)
      ]),
    );
  }
}
