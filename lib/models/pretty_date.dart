class PrettyDate {
  final DateTime dateTime;

  PrettyDate({required this.dateTime});

  String toString() {
    return '${_dayOfWeek(dateTime.weekday)}, ${_threeCharMonth(dateTime.month)} ${dateTime.day}, '
        '${dateTime.year} at ${_twelveHourTime()}';
  }

  String get prettyDate =>
      '${_dayOfWeek(dateTime.weekday)}, ${_threeCharMonth(dateTime.month)} ${dateTime.day}, '
      '${dateTime.year}';
  String get prettyTime => '${_twelveHourTime()}';
  String get weekDay => '${_dayOfWeek(dateTime.weekday)}';
  String get monthAbbr => '${_threeCharMonth(dateTime.month)}';

  String _dayOfWeek(int day) {
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[day - 1];
  }

  String _threeCharMonth(int monthNum) {
    List<String> month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return month[monthNum - 1];
  }

  String _twelveHourTime() {
    String _meridies = dateTime.hour <= 11 ? 'AM' : 'PM';
    String _hour = (dateTime.hour % 12 == 0) ? '12' : '${dateTime.hour % 12}';
    String _minute = '${dateTime.minute.toString().padLeft(2, '0')}';
    return '$_hour:$_minute $_meridies';
  }
  
}
