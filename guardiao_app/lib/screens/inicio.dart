import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:guardiao_app/controllers/LocalizacaoController.dart';
import 'package:guardiao_app/presentation/custom_icons_icons.dart';
import 'package:guardiao_app/widgets/mapa.dart';



class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _indiceMenu = 0;
  late double longitude;
  late double latitude;

  @override
  void initState() async {
    longitude = 0;
    latitude = 0;
    await getLocalizacaoAtual().then((value) {
      print("position: ${value}");
      latitude = value.latitude;
      longitude = value.longitude;
      print(latitude);
    });
    print("longitude: ${longitude}");

    super.initState();
  }

  Future<Position> getLocalizacaoAtual() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Serviços de localização desativados.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission==LocationPermission.denied) {
        return Future.error('Permissão para localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão para localização negada para sempre.');
    }

    Position pos = await Geolocator.getCurrentPosition();

    return pos;
  }
  
  @override
  Widget build(BuildContext context) {
    //double latitude = 0; //= -22.9021287822007;
    //double longitude = 0; // = -47.06691060187551;

    return Scaffold(
      body: OpenStreetMapSearchAndPick(
        //center: const LatLong(-22.9021287822007, -47.06691060187551),
        center: LatLong(latitude, longitude),
        //center: LatLong(lbController.latitude, lbController.longitude),
        onPicked: (value){
        }, 
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

  // Future<Position> _posicaoAtual() async {
  //   LocationPermission permissao;
    
  //   bool ativado = await Geolocator.isLocationServiceEnabled();
  //   if (!ativado) {
  //     return Future.error('Por favor, habilite a localização no smartphone');
  //   }

  //   permissao = await Geolocator.checkPermission();
  //   if (permissao == LocationPermission.denied) {
  //     permissao = await Geolocator.requestPermission();
  //     if (permissao == LocationPermission.denied) {
  //       return Future.error('Você precisa autorizar o acesso à localização.');
  //     }
  //   }

  //   if (permissao == LocationPermission.deniedForever) {
  //     return Future.error('Você precisa autorizar o acesso à localização.');
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }
}