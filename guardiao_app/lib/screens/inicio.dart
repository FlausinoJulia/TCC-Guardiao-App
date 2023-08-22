import 'package:flutter/material.dart';
import 'package:guardiao_app/presentation/custom_icons_icons.dart';
import 'package:guardiao_app/widgets/mapa.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _indiceMenu = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
        center: const LatLong(-22.902109016015434, -47.066974974805134),
        
        onPicked: (value){}, 
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