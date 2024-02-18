
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:wikipedia/wikipedia.dart';
import 'package:worldtime/worldtime.dart';

ThemeData theme = ThemeData();
getTheme(ThemeData currentTheme){
  theme = currentTheme;
}

Widget getPlaceTime(double lat, double long) {
  return FutureBuilder<String>(
    future: placeTime(lat, long),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text(" --");
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return Text(" ${snapshot.data!.split(", ")[0].split(" - ")[1]}",style: theme.textTheme.labelMedium,);
      }
    },
  );
}
Future<String> placeTime(double lat, double long) async{
  final _worldtimePlugin = Worldtime();
  const String myFormatter = 'time - \\h:\\m, date - \\D/\\M/\\Y';
  final DateTime timeAmsterdamGeo = await _worldtimePlugin
      .timeByLocation(latitude: lat, longitude: long);
  final String resultGeo = _worldtimePlugin
      .format(dateTime: timeAmsterdamGeo, formatter: myFormatter);
  return resultGeo;

}

Widget getPlaceWeather(double lat, double long){
  return FutureBuilder(
      future: placeWeather(lat, long),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("  --");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text("  ${snapshot.data.round()} °C",style: theme.textTheme.labelMedium,);
        }
      });
}
Future placeWeather(double lat, double long) async{
  WeatherFactory wf = WeatherFactory("32549f2ee99a8b413279a95b1ef502b6");
  Weather w = await wf.currentWeatherByLocation(lat,long);
  return w.temperature!.celsius;
}

Widget getPlaceDescription(String place){
  return FutureBuilder(
      future: placeDescription(place),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("  --");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text("${snapshot.data}",style: theme.textTheme.labelMedium,);
        }
      });
}

Future placeDescription(String place) async {
  String description = "";
  try{
    Wikipedia instance = Wikipedia();
    var result = await instance.searchQuery(searchQuery: "$place",limit: 1);
    for(int i=0; i<result!.query!.search!.length; i++){
      description+="${result.query!.search![i].snippet}. \n";
    }
    var resultt = await instance.searchQuery(searchQuery: "Talk about $place",limit: 1);
    for(int i=0; i<resultt!.query!.search!.length; i++){
      if (description != "${resultt.query!.search![i].snippet}. \n") {
        description += "${resultt.query!.search![i].snippet}. \n";
      }
    }
  }catch(e){
    print(e);
  }
  return description;
}
