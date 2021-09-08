import 'package:flutter/material.dart';

class DayTempBar extends StatelessWidget {
  final double high;
  final double low;
  final String day;

  const DayTempBar(
      {Key? key,
      required this.high,
      required this.low,
      required this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Theme.of(context).primaryColorLight,
          height: 100,
          width: 20,
        ),
        Container(
          color: Theme.of(context).primaryColor,
          height: high,
          width: 20,
        ),
        Container(
          color: Theme.of(context).primaryColorLight,
          height: low,
          width: 20,
        ),
        Text(day),
      ],
    );
  }
}
