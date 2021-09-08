class Location {
  String city;
  String state;

  Location.fromJson(Map<String, dynamic> json)
      : city = json['results'][0]['locations'][0]['adminArea5'],
        state = json['results'][0]['locations'][0]['adminArea3'];

  String toString() {
    return '$city, $state';
  }
}
