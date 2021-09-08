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
    int sunrise = report.current!.sunrise! * 1000;
    //int dtn = DateTime.now().millisecondsSinceEpoch;
    print('Sunrise: $sunrise');
    print(
        'Parsed DT: ${DateTime.fromMillisecondsSinceEpoch(report.current!.sunrise! * 1000)}');

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: Column(
          children: [
            detailItem(Icons.date_range, report.current!.formattedDT),
            detailItem(Icons.wb_sunny,
                '${DateTime.fromMillisecondsSinceEpoch(report.current!.sunrise! * 1000)}'),
            detailItem(
                Icons.mode_night, ''),
          ],
        ));
  }
}

Widget detailItem(IconData icon, String text) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(icon), Text(text)]);
}