import 'package:flutter/material.dart';
import 'package:guardiao_app/widgets/mapa.dart';
import 'package:latlong2/latlong.dart';

import '../../utils.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLocalizacaoAtual(), // Execute your asynchronous method here
      builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data to be loaded, display a loading indicator
          return const Center(child: CircularProgressIndicator(),); 
        } else if (snapshot.hasError) { // nao foi permitida a localizacao
          // If an error occurred, display an error message
          return Scaffold(
            body: OpenStreetMapSearchAndPick(
              center: const LatLong(-22.90207936673223, -47.066738940426944),
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