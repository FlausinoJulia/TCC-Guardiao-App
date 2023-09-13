import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

const String baseUrl = 'https://api.openrouteservice.org/v2/directions/foot-walking';
const String apiKey = Env.orsApiKey;


// startPoint is an String containing longitude and latitude of the starting point of the route
getCoordinates(String startPoint, String endPoint) async  {
  List listOfPoints = [];
  List<LatLng> points = [];
  
  var url = Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    listOfPoints = data['features'][0]['geometry']['coordinates'];
    points = listOfPoints
      .map((e) => LatLng(e[1].toDouble(), e[0].toDouble()))
      .toList();
  }

  return points;
}