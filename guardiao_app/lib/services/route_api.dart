import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

const String baseUrl = 'https://api.openrouteservice.org/v2/directions/foot-walking';
final String apiKey = dotenv.get('ORS_API_KEY', fallback: "");

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