import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardiao_app/services/firebase_auth.dart';
import 'package:guardiao_app/widgets/mapa.dart';



class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  //late double longitude;
  //late double latitude;

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

    String uid = getUid()!;
    Firestore.adicionarLocalizacao(uid, GeoPoint(pos.latitude, pos.longitude));

    return pos;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLocalizacaoAtual(), // Execute your asynchronous method here
      builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data to be loaded, display a loading indicator
          return const Center(child: CircularProgressIndicator(),); 
        } else if (snapshot.hasError) {
          // If an error occurred, display an error message
          //return Text('Error: ${snapshot.error}');
          return Scaffold(
            body: OpenStreetMapSearchAndPick(
              center: LatLong(snapshot.data!.latitude, snapshot.data!.longitude),
              onPicked: (value){
              }, 
            ),
          );
        } else {
          return Scaffold(
            body: OpenStreetMapSearchAndPick(
              center: LatLong(snapshot.data!.latitude, snapshot.data!.longitude),
              onPicked: (value){
              }, 
            ),
          );
        }
      },
    );
  }
}