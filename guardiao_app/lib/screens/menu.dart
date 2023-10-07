import 'package:flutter/material.dart';
import 'package:guardiao_app/presentation/custom_icons_icons.dart';

import 'inicio.dart';
import 'alarme/alarme.dart';
import 'denuncias/denuncias.dart';
import 'perfil/perfil.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int indiceMenu = 0;

  final telas = [
    const TelaInicial(),
    const TelaDenuncias(),
    const TelaAlarme(),
    const TelaPerfil(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: indiceMenu,
        children: telas
      ),
      bottomNavigationBar: ClipRRect(
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
            currentIndex: indiceMenu,
            onTap: (value) {
              setState(() => indiceMenu = value);
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
      //),
    );
  }
}