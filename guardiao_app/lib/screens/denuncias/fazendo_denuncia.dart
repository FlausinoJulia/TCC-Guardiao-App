import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:guardiao_app/widgets/mapa.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class TelaFazendoDenuncia extends StatefulWidget {
  const TelaFazendoDenuncia({super.key});

  @override
  State<TelaFazendoDenuncia> createState() => _TelaFazendoDenunciaState();
}

class _TelaFazendoDenunciaState extends State<TelaFazendoDenuncia> {
  final TextEditingController _localizacaoController = TextEditingController();
  final TextEditingController _descricaoController   = TextEditingController();
  
  LatLng local = LatLng(-22.90207936673223, -47.066738940426944);
  MapController mapController = MapController();
  
  final baseUri = 'https://nominatim.openstreetmap.org';
  List<OSMdata> _options = <OSMdata>[];
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 100.0),
                child: Row(
                  children: [
                    IconButton (
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0XFF1034B4),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                    ),
                    const SizedBox(width: 15.0,),
                    const Text(
                      "Fazendo denúncia",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                      ),
                    ),
                    
                  ],
                ),
              ),
              SizedBox( 
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    onTap: (tapPosition, point) => {
                      local = point,

                      if (_debounce?.isActive ?? false) _debounce?.cancel(),
                      _debounce = 
                        Timer(const Duration(milliseconds: 1000), () async {
                          var client = http.Client();  
                            try {
                              String url =
                                '$baseUri/reverse?lat=${local.latitude}&lon=${local.longitude}&format=json&plygon_geojson=1';

                              var response = await client.get(Uri.parse(url));
                              Map<String, dynamic> responseJson = json.decode(response.body);
                              _localizacaoController.text = responseJson['display_name'];

                              setState(() {});
                            } finally {
                              client.close();
                            }
                            setState(() {});
                          }
                        ),

                    },
                    center: local,
                    zoom: 17,
                    maxZoom: 17,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        if (local != LatLng(0,0)) 
                          Marker(
                            point: local, 
                            builder: (context) => const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                      ],
                    ),
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                child: Form (
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child:  Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text("Selecione no mapa ou digite abaixo onde aconteceu o incidente."),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _localizacaoController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                filled: true, 
                                fillColor: const Color(0xFFF3F3F3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                labelText: "Onde ocorreu?",
                                labelStyle: const TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color(0xFF6C6C6C),
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                              ),
                              onChanged: (String value) {
                                if (_debounce?.isActive ?? false) _debounce?.cancel();

                                _debounce = 
                                  Timer(const Duration(milliseconds: 1000), () async {
                                    var client = http.Client();  
                                    try {
                                      String url =
                                        '$baseUri/search?q=$value&format=json&polygon_geojson=1&addressdetails=1';

                                      var response = await client.get(Uri.parse(url));
                                      var decodedResponse =
                                        jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

                                      _options = decodedResponse
                                        .map((e) => OSMdata(
                                          displayname: e['display_name'],
                                          lat: double.parse(e['lat']),
                                          lon: double.parse(e['lon'])
                                        )).toList();

                                      setState(() {});
                                    } finally {
                                      client.close();
                                    }
                                    setState(() {});
                                  });
                              },
                            ),
                            StatefulBuilder(builder: ((context, setState) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _options.length > 5 ? 5 : _options.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_options[index].displayname),
                                    subtitle: Text(
                                      '${_options[index].lat},${_options[index].lon}'
                                    ),
                                    onTap: () {
                                      _localizacaoController.text = _options[index].displayname;
                                      double lat = _options[index].lat;
                                      double lon = _options[index].lon;
                                      LatLng newLocal = LatLng(lat, lon);
                                      local = newLocal;
                                      setState(() {});
                                      
                                      mapController.move(local, 17.0);
                                      _options.clear();
                                    },
                                  );
                                },
                              );
                            })),
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text("Dê uma breve descrição sobre o ocorrido.")
                          ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextFormField(
                          controller: _descricaoController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                            filled: true, 
                            fillColor: const Color(0xFFF3F3F3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            labelText: "O que aconteceu?",
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                              fontFamily: 'Lato',
                              color: Color(0xFF6C6C6C),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          maxLines: 8,
                          minLines: 6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ElevatedButton(
                          onPressed: () {}, 
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width, 60.0),
                            backgroundColor: const Color(0xFF040268),
                            padding: const EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          child: const Text(
                            "Fazer denúncia",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
