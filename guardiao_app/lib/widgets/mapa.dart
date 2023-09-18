// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/screens/boas_vindas.dart';
import 'package:guardiao_app/services/firebase_auth.dart';
import 'package:guardiao_app/services/route_api.dart';
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
  
  bool estaVisivel = false;
  List<LatLng> coordenadasDaRota = [];
  List<Marker> marcadores = [];
  
  //Marker marcadorDestino = Marker(point: LatLng(0,0), builder: (context) => const Icon(Icons.abc, size: 0,));
  //late Marker marcadorLocAtual;

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

    _mapController.mapEventStream.listen((event) async { // aqui esta atualizando toda vez que move (definindo o evento do mapa)
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

    //marcadorLocAtual = Marker();

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
      child: SizedBox(
        width: double.infinity,
        height:  double.infinity,
        child: Stack(
          children: <Widget> [
            FlutterMap(
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
                PolylineLayer(
                  polylineCulling: false,
                  polylines: [
                    Polyline(
                      points: coordenadasDaRota,
                      color: Colors.blue,
                      strokeWidth: 5,
                    )
                  ],
                ),
                MarkerLayer(
                  markers: [
                    if (latLocal != 0 && lonLocal != 0) 
                      Marker(
                        point: LatLng(latLocal, lonLocal),
                        builder:(context) => Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    if (latDestiny != 0 && lonDestiny != 0)
                      Marker(
                        point: LatLng(latDestiny, lonDestiny),
                        builder:(context) => Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),                    
                  ],
                ),
              ],
            ),
            Container(
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
                    onPressed: () {
                      logout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaBoasVindas(), 
                        ),
                      );
                    }, 
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
                        // onTap: () {
                        //   _destinyController.clear();
                        // },
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
                              onTap: () async {
                                _destinyController.text = _destinyOptions[index].displayname;
                                // definindo a coordenada de destino
                                latDestiny = _destinyOptions[index].lat;
                                lonDestiny =  _destinyOptions[index].lon;
      
                                // armazenando novo destino no firestore
                                String uid = getUid()!;
                                Firestore.adicionarDestino(uid, GeoPoint(latDestiny, lonDestiny));

                                // se o destino e a loc atual estiverem preenchidos
                                if (_searchController.text.isNotEmpty && latLocal != 0 && lonLocal != 0 && 
                                    _destinyController.text.isNotEmpty && latDestiny != 0 && lonDestiny != 0) {
                                    
                                  // mostrar a rota e deixar o card visivel
                                  coordenadasDaRota.clear();
                                  coordenadasDaRota = await getCoordinates("$lonLocal,$latLocal", "$lonDestiny,$latDestiny");
                                  if (coordenadasDaRota == [] && context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Não foi possível encontrar uma rota',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Color.fromARGB(255, 198, 94, 87),
                                      ),
                                    );
                                  }
                                  estaVisivel = true; // depois do set state o card deverá estar visivel
                                }
      
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
                        // onTap: () {
                        //   _searchController.clear();
                        // },
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
                                    18.0);
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

            
            Visibility(
              visible: estaVisivel,
              child: Positioned(
                bottom: 10,
                left: 3,
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.white,
                    child: SizedBox(
                      width: 345.0,
                      height: 140.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 18.0, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Deseja iniciar a viagem?",
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                IconButton (
                                  icon: const Icon(
                                    Icons.cancel_rounded,
                                    color: Color.fromARGB(255, 150, 150, 150)
                                  ),
                                  onPressed: () {
                                    estaVisivel = false;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // verificar se tem pessoas indo para o mesmo lugar
                                Firestore.getUsuariosComMesmoDestino(GeoPoint(latDestiny, lonDestiny));
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(MediaQuery.of(context).size.width, 46.0),
                                backgroundColor: const Color(0xFF040268),
                                padding: const EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ), 
                              child: const Center(
                                child: Text(
                                  "Iniciar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
         
         ],
        ),
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
