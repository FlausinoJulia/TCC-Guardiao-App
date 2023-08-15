import 'package:flutter/material.dart';
import 'package:guardiao_app/presentation/custom_icons_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';


class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _indiceMenu = 0;
 // final _mapController = MapController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack (
          clipBehavior: Clip.none,
          children: [
            FlutterMap(
              options: MapOptions(
                center: const LatLng(-22.902181930872175, -47.06698501217295),
                zoom: 18.0,
              ), 
              children: [
                TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
           // OSMFlutter(
            //  controller: ,
            //),
            Container(
              height: 160.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, spreadRadius: 0.0, blurRadius: 10.0)
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
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
                    ),
                    const SizedBox(height: 15.0,),
                    TextField(
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
                          ///fontSize: 15.0,
                          color: Color(0xFF6C6C6C),
                          //fontWeight: FontWeight.bold,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
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
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        decoration: const BoxDecoration(
          borderRadius:  BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0.0, blurRadius: 10.0)
          ]
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only (
            topLeft:Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            iconSize: 25.0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF040268),
            selectedItemColor: const Color(0xFF3640F1),
            unselectedItemColor: Colors.white,
            currentIndex: _indiceMenu,
            onTap: (value) {
              setState(() => _indiceMenu = value);
            },
            items: const [
             BottomNavigationBarItem (
                label: 'Início', 
                icon: Icon(CustomIcons.inicio),
              ),
              BottomNavigationBarItem (
                label: 'Denúncias', 
                icon: Icon(CustomIcons.denuncias),
              ),
              BottomNavigationBarItem (
                label: 'Alarme', 
                icon: Icon(CustomIcons.alarme),
              ),
              BottomNavigationBarItem (
                label: 'Perfil', 
                icon: Icon(CustomIcons.perfil),
              ),
            ],
          ),
        ),
      ),
    );
  }
}