import 'package:flutter/material.dart';
import 'package:weather/components/day_temp_bar.dart';
import 'package:weather/models/weather_report.dart';
import '../models/location.dart';

class WeatherDisplay extends StatefulWidget {
  final Location location;
  final WeatherReport report;

  static const Map<String, String> imageMap = {
    '01d': 'assets/images/sun.png',
    '01n': 'assets/images/moon-phase.png',
    '02d': 'assets/images/sun_with_cloud.png',
    '02n': 'assets/images/moon.png',
    '03d': 'assets/images/clouds.png',
    '03n': 'assets/images/clouds.png',
    '04d': 'assets/images/broken_cloud.png',
    '04n': 'assets/images/broken_cloud.png',
    '09d': 'assets/images/shower_rain.png',
    '09n': 'assets/images/shower_rain.png',
    '10d': 'assets/images/rain.png',
    '10n': 'assets/images/rain.png',
    '11d': 'assets/images/storm.png',
    '11n': 'assets/images/storm.png',
    '13d': 'assets/images/snow.png',
    '13n': 'assets/images/snow.png',
    '50d': 'assets/images/mist.png',
    '50n': 'assets/images/mist.png',
  };

  WeatherDisplay({Key? key, required this.location, required this.report})
      : super(key: key);

  @override
  _WeatherDisplayState createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  late bool showFeelsLike;

  @override
  void initState() {
    super.initState();
    showFeelsLike = false;
  }

  @override
  Widget build(BuildContext context) {
    final Image weatherImage = Image.asset(
        WeatherDisplay.imageMap[widget.report.current!.weather![0].icon] ??
            WeatherDisplay.imageMap['01d']!);

    final Text weatherDescription = Text(
        widget.report.current!.weather![0].main,
        style: Theme.of(context).textTheme.headline4);

    final Text temperature = Text(
      '${widget.report.current!.temp!.round()}',
      style: Theme.of(context).textTheme.headline4,
    );

    final Column feelsLike = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Feels',
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          '${widget.report.current?.feelsLike?.round()}',
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );

    final Stack stack = Stack(alignment: Alignment.center, children: [
      weatherImage,
      feelsLike,
    ]);

    return Padding(
      padding: const EdgeInsets.all(28.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            weatherDescription,
            temperature,
          ],
        ),
        GestureDetector(
          child: showFeelsLike ? stack : weatherImage,
          onTap: () {
            showFeelsLike = !showFeelsLike;
            setState(() {});
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: tempBarList(),
        )
      ]),
    );
  }

  List<DayTempBar> tempBarList() {
    String days = 'MTWRFSS';
    int today = DateTime.now().weekday - 1;

    List<DayTempBar> list = [];
    int i = 0;

    while (i < 7) {
      list.add(DayTempBar(
        high: widget.report.daily![i].temp!.max!.toDouble(),
        low: widget.report.daily![i].temp!.min!.toDouble(),
        day: days[(i + today) % 7],
      ));
      i++;
    }

    return list;
  }
}
