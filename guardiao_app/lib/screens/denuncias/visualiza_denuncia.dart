import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/denuncia.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:latlong2/latlong.dart';

class TelaVisualizandoDenuncia extends StatefulWidget {
  const TelaVisualizandoDenuncia({super.key, required this.denuncia});
  final Denuncia denuncia;

  @override
  State<TelaVisualizandoDenuncia> createState() => _TelaVisualizandoDenunciaState();
}

class _TelaVisualizandoDenunciaState extends State<TelaVisualizandoDenuncia> {  
  LatLng? local;
  Usuario? usuario;

  @override
  void initState() {
    local =  LatLng(widget.denuncia.local.latitude, widget.denuncia.local.longitude);
    pegarUsuario();
    super.initState();
  }

    pegarUsuario() async {
      usuario = await Firestore.getUsuarioAtual();
      setState(() {});
    }

  Future<Widget> loadProfileImage() async {
    if (usuario != null && usuario!.imagem != "") {
      final imagemUrl = usuario!.imagem;
      final imagem = await FirebaseStorage.instance.ref(imagemUrl).getDownloadURL();
      return CircleAvatar(
        radius: 20,
        backgroundImage:  NetworkImage(imagem),
      );
    } else {
      return const CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg"),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column (
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
                      "Visualizando denúncia",
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
                  options: local != null ? MapOptions(
                    center: local,
                    zoom: 17,
                    maxZoom: 17,
                    interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom
                  ) : MapOptions (
                    center: LatLng(-22.90074534849959, -47.06715141665595),
                    zoom: 17,
                    maxZoom: 17,
                    interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        if (local != null || local != LatLng(0,0)) 
                          Marker(
                            point: local!, 
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
                padding: const EdgeInsets.all(20.0),
                child: Row (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder<Widget>(
                      future: loadProfileImage(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return snapshot.data!;
                        }
                      },
                    ),
                    const SizedBox(width: 20.0,),
                    Text(
                      (usuario != null) ? usuario!.nome : "",
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.denuncia.descricao,
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color(0xFFD9D9D9),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Color(0xFF02006C),
                            size: 25.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text (
                              widget.denuncia.endereco,
                              style: const TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                color: Color(0xFF02006C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}