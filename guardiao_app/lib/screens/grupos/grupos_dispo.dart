import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/grupo.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:latlong2/latlong.dart';

class TelaGruposDisponiveis extends StatefulWidget {
  const TelaGruposDisponiveis({super.key, required this.destino, required this.enderecoDestino});

  final LatLng destino;
  final String enderecoDestino;

  @override
  State<TelaGruposDisponiveis> createState() => _TelaGruposDisponiveisState();
}

class _TelaGruposDisponiveisState extends State<TelaGruposDisponiveis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  "Grupos",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
                stream: Firestore.getGrupos(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center (
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: Center (
                        child: Text("Não há nenhum grupo indo para ${widget.enderecoDestino} disponível no momento...\n Deseja criar um grupo?"),
                      ),
                    );
                  }
                  else {
                    return  Expanded(
                      child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((document) {
                              return FutureBuilder<Usuario?> (
                                future: Firestore.getUsuario(document['administrador']),
                                builder: (BuildContext context, AsyncSnapshot<Usuario?> userSnapshot) {
                                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (userSnapshot.hasData == false){
                                  
                                  }else {
                                    final grupo = Grupo.fromFirestore(
                                      document as DocumentSnapshot<Map<String, dynamic>>,
                                      null
                                    );
                                    return CardGrupo(
                                      grupo: grupo,
                                      nomeAdmin: userSnapshot.data!.nome,
                                      fotoAdmin: userSnapshot.data!.imagem
                                    );
                                  } 
                                }
                              );
                            }).toList(),
                          ),
                    );
                  }
                },
              ),
        ],
      ),
    );
  }
}