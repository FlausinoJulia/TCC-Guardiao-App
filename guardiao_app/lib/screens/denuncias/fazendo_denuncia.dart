import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TelaFazendoDenuncia extends StatefulWidget {
  const TelaFazendoDenuncia({super.key});

  @override
  State<TelaFazendoDenuncia> createState() => _TelaFazendoDenunciaState();
}

class _TelaFazendoDenunciaState extends State<TelaFazendoDenuncia> {
  LatLng local = LatLng(-22.90207936673223, -47.066738940426944);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton (
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0XFF1034B4),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // tem que voltar o user?
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
                  options: MapOptions(
                    onTap: (tapPosition, point) => {
                      print(point.toString()),
                      local = point,
                      setState(() {})
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
                          )

                      ],
                    ),
                  ]
                ),
              ),
              Form(
                child: Column(
                  children: [
                    Text("Selecione no mapa ou digite abaixo onde aconteceu o incidente."),
                    TextFormField(),
                    Text("Dê uma breve descrição sobre o ocorrido."),
                    TextFormField(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
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
            ],
          ),
        ),
      ),
    );
  }
}