import 'package:flutter/material.dart';

class UVItext extends StatelessWidget {
  final double uvi;
  UVItext({Key? key, required this.uvi}) : super(key: key);

  Color getColor(double uvi) {
    if (uvi > 10)
      return Colors.purple;
    else if (uvi > 8)
      return Colors.red;
    else if (uvi > 6)
      return Colors.orange;
    else if (uvi > 3)
      return Colors.yellow;
    else
      return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = getColor(uvi);
    return Text(
      '$uvi',
      style: TextStyle(color: textColor),
    );
  }
}
