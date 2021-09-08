import 'package:flutter/material.dart';
import '../models/weather_report.dart';
import '../models/pretty_date.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherReport report;
  static const routeName = 'detail';
  static const appBarTitle = 'Weather Report Details';
  const WeatherDetailScreen({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //int dt = report.current!.dt! * 1000;
    //int dtn = DateTime.now().millisecondsSinceEpoch;
    //print('DT: $dt');
    //print('Parsed DT: ${DateTime.fromMillisecondsSinceEpoch(dt)}');

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: Column(
          children: [
            detailItem(Icons.date_range, formatPrettyDate(report.current!.dt!)),
            detailItem(
                Icons.wb_sunny,
                formatPrettyDate(
                    report.current!.sunrise! - report.timezoneOffset!)),
            detailItem(
                Icons.mode_night,
                formatPrettyDate(
                    report.current!.sunset! - report.timezoneOffset!)),
          ],
        ));
  }
}

Widget detailItem(IconData icon, String text) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(icon), Text(text)]);
}

String formatPrettyDate(int secondsSinceEpoch) {
  return PrettyDate(
          dateTime:
              DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000))
      .prettyTime;
}
