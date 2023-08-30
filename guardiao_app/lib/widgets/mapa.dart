// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'package:guardiao_app/presentation/custom_icons_icons.dart';

class OpenStreetMapSearchAndPick extends StatefulWidget {
  final LatLong center;     // coordenada do centro do mapa
  // final LatLong destiny;    // coordenada do destino
  // final LatLong localPlace; // coordenada da localização atual
  final void Function(PickedData pickedData) onPicked; // o que vai fazer ao selecionar a loc?
  final Future<LatLng> Function() onGetCurrentLocationPressed;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;
  final IconData currentLocationIcon;
  final IconData locationPinIcon;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color locationPinIconColor;
  final String locationPinText;
  final TextStyle locationPinTextStyle;
  final String buttonText;
  final String hintText;
  final double buttonHeight;
  final double buttonWidth;
  final TextStyle buttonTextStyle;
  final String baseUri;

  static Future<LatLng> nopFunction() {
    throw Exception("");
  }

  const OpenStreetMapSearchAndPick(
      {Key? key,
      this.center = const LatLong(0, 0),
      // this.destiny = const LatLong(0, 0),
      // this.localPlace = const LatLong(0, 0),
      required this.onPicked,
      this.zoomOutIcon = Icons.zoom_out_map,
      this.zoomInIcon = Icons.zoom_in_map,
      this.currentLocationIcon = Icons.my_location,
      this.onGetCurrentLocationPressed = nopFunction,
      this.buttonColor = Colors.blue,
      this.locationPinIconColor = Colors.blue,
      this.locationPinText = 'Location',
      this.locationPinTextStyle = const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
      this.hintText = 'Search Location',
      this.buttonTextStyle = const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      this.buttonTextColor = Colors.white,
      this.buttonText = 'Set Current Location',
      this.buttonHeight = 50,
      this.buttonWidth = 200,
      this.baseUri = 'https://nominatim.openstreetmap.org',
      this.locationPinIcon = Icons.location_on})
      : super(key: key);

  @override
  State<OpenStreetMapSearchAndPick> createState() =>
      _OpenStreetMapSearchAndPickState();
}

class _OpenStreetMapSearchAndPickState
    extends State<OpenStreetMapSearchAndPick> {
  MapController _mapController = MapController();
  
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _destinyController = TextEditingController();
  
  final FocusNode _focusNode = FocusNode();
  final FocusNode _destinyFocusNode = FocusNode();

  // coordenadas de local
  double latLocal = 0;
  double lonLocal = 0;

  // coordenadas de destino
  double latDestiny = 0;
  double lonDestiny = 0;

  //LatLong localPlace = const LatLong(0, 0);

  List<OSMdata> _options = <OSMdata>[];
  List<OSMdata> _destinyOptions = <OSMdata>[];
  Timer? _debounce;
  var client = http.Client();

  void setNameCurrentPos() async {
    double latitude = _mapController.center.latitude;
    double longitude = _mapController.center.longitude;    

    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }
    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    // var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  void setNameCurrentPosAtInit() async {
    double latitude = widget.center.latitude;
    double longitude = widget.center.longitude;

    // definindo a coordenada atual
    latLocal = widget.center.latitude;
    lonLocal = widget.center.longitude;

    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }

    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    // var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  @override
  void initState() {
    _mapController = MapController();

    setNameCurrentPosAtInit();

    _mapController.mapEventStream.listen((event) async {
      if (event is MapEventMoveEnd) {
        var client = http.Client();
        String url =
            '${widget.baseUri}/reverse?format=json&lat=${event.center.latitude}&lon=${event.center.longitude}&zoom=18&addressdetails=1';

        var response = await client.get(Uri.parse(url));
        // var response = await client.post(Uri.parse(url));
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
            as Map<dynamic, dynamic>;

        _searchController.text = decodedResponse['display_name'];
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
              child: FlutterMap(
            options: MapOptions(
                center: LatLng(widget.center.latitude, widget.center.longitude),
                zoom: 15.0,
                maxZoom: 18,
                minZoom: 6),
            mapController: _mapController,
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
                // attributionBuilder: (_) {
                //   return Text("© OpenStreetMap contributors");
                // },
              ),
            ],
          )),
          Positioned(
            child: Container(
              height: 160.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0.0,
                    blurRadius: 10.0,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
              top: 180.0,
              right: 20.0,
              child: Container(
                width: 200.0,
                height: 35.0,
                decoration: const BoxDecoration(
                  borderRadius:  BorderRadius.all(Radius.circular(10.0)),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {}, 
                  icon: const Icon(
                    CustomIcons.visivel, 
                    size: 20.0,
                    color: Color(0xFF6C6C6C),
                  ), 
                  label: const Text("Exibir zonas de perigo",
                  style: TextStyle(
                      color: Color(0xFF6C6C6C),
                      fontFamily: 'Lato',
                      fontSize: 15.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white,),
                ),
              ),
            ),

          // destiny positioned
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  TextFormField (
                      controller: _destinyController,
                      focusNode: _destinyFocusNode,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.search_rounded),
                        iconColor:  const Color(0xFF6C6C6C),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                        filled: true,
                        fillColor: const Color(0xFFEFEFEF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        labelText: "Para onde você vai?",
                        labelStyle: const TextStyle(
                          fontFamily: 'Lato',
                          color: Color(0xFF6C6C6C),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      onTap: () {
                        _destinyController.clear();
                      },
                      onChanged: (String value) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();

                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () async {
                          if (kDebugMode) {
                            print(value);
                          }
                          var client = http.Client();
                          try {
                            String url =
                                '${widget.baseUri}/search?q=$value&format=json&polygon_geojson=1&addressdetails=1';
                            if (kDebugMode) {
                              print(url);
                            }
                            var response = await client.get(Uri.parse(url));
                            // var response = await client.post(Uri.parse(url));
                            var decodedResponse =
                                jsonDecode(utf8.decode(response.bodyBytes))
                                    as List<dynamic>;
                            if (kDebugMode) {
                              print(decodedResponse);
                            }
                            _destinyOptions = decodedResponse
                                .map((e) => OSMdata(
                                    displayname: e['display_name'],
                                    lat: double.parse(e['lat']),
                                    lon: double.parse(e['lon'])))
                                .toList();
                            setState(() {});
                          } finally {
                            client.close();
                          }

                          setState(() {});
                        });
                      }),
                  
                  StatefulBuilder(builder: ((context, setState) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _destinyOptions.length > 5 ? 5 : _destinyOptions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_destinyOptions[index].displayname),
                            subtitle: Text(
                                '${_destinyOptions[index].lat},${_destinyOptions[index].lon}'),
                            onTap: () {
                              _destinyController.text = _destinyOptions[index].displayname;
                              // definindo a coordenada de destino
                              latDestiny = _destinyOptions[index].lat;
                              lonDestiny =  _destinyOptions[index].lon;

                              _focusNode.unfocus();
                              _destinyOptions.clear();
                              setState(() {});
                            },
                          );
                        });
                  })),
                ],
              ),
            ),
          ),
          
          // local place positioned
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  TextFormField (
                      controller: _searchController,
                      focusNode: _focusNode,
                      decoration:  InputDecoration(
                        icon: const Icon(Icons.location_pin),
                        iconColor:  const Color(0xFF6C6C6C),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                        filled: true,
                        fillColor: const Color(0xFFEFEFEF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        labelText: "Onde você está?",
                        labelStyle: const TextStyle(
                          fontFamily: 'Lato',
                          color: Color(0xFF6C6C6C),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      onTap: () {
                        _searchController.clear();
                      },
                      onChanged: (String value) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();

                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () async {
                          if (kDebugMode) {
                            print(value);
                          }
                          var client = http.Client();
                          try {
                            String url =
                                '${widget.baseUri}/search?q=$value&format=json&polygon_geojson=1&addressdetails=1';
                            if (kDebugMode) {
                              print(url);
                            }
                            var response = await client.get(Uri.parse(url));
                            // var response = await client.post(Uri.parse(url));
                            var decodedResponse =
                                jsonDecode(utf8.decode(response.bodyBytes))
                                    as List<dynamic>;
                            if (kDebugMode) {
                              print(decodedResponse);
                            }
                            _options = decodedResponse
                                .map((e) => OSMdata(
                                    displayname: e['display_name'],
                                    lat: double.parse(e['lat']),
                                    lon: double.parse(e['lon'])))
                                .toList();
                            setState(() {});
                          } finally {
                            client.close();
                          }

                          setState(() {});
                        });
                      }),
                  
                  StatefulBuilder(builder: ((context, setState) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _options.length > 5 ? 5 : _options.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_options[index].displayname),
                            subtitle: Text(
                                '${_options[index].lat},${_options[index].lon}'),
                            onTap: () {
                              _searchController.text = _options[index].displayname;
                              _mapController.move(
                                  LatLng(
                                      _options[index].lat, _options[index].lon),
                                  15.0);
                              // definindo coordenadas da loc. atual
                              latLocal = _options[index].lat;
                              lonLocal = _options[index].lon;

                              _focusNode.unfocus();
                              _options.clear();
                              setState(() {});
                            },
                          );
                        });
                  })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<PickedData> pickData() async {
    LatLong center = LatLong(
        _mapController.center.latitude, _mapController.center.longitude);
    var client = http.Client();
    String url =
        '${widget.baseUri}/reverse?format=json&lat=${_mapController.center.latitude}&lon=${_mapController.center.longitude}&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    // var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    String displayName = decodedResponse['display_name'];
    return PickedData(center, displayName, decodedResponse["address"]);
  }
}

class OSMdata {
  final String displayname;
  final double lat;
  final double lon;
  OSMdata({required this.displayname, required this.lat, required this.lon});
  @override
  String toString() {
    return '$displayname, $lat, $lon';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OSMdata && other.displayname == displayname;
  }

  @override
  int get hashCode => Object.hash(displayname, lat, lon);
}

class LatLong {
  final double latitude;
  final double longitude;
  const LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String addressName;
  final Map<String, dynamic> address;

  PickedData(this.latLong, this.addressName, this.address);
}
