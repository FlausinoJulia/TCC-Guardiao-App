import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/grupo.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:guardiao_app/widgets/card_grupo.dart';
import 'package:latlong2/latlong.dart';

class TelaGruposDisponiveis extends StatefulWidget {
  const TelaGruposDisponiveis({super.key, required this.destino, required this.enderecoDestino});

  final LatLng destino;
  final String enderecoDestino;

  @override
  State<TelaGruposDisponiveis> createState() => _TelaGruposDisponiveisState();
}

class _TelaGruposDisponiveisState extends State<TelaGruposDisponiveis> {
  int numMaxParticipantes = 2;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Criando Grupo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Criando grupo com destino a ${widget.enderecoDestino}'),
                const SizedBox(height: 20.0,),
                Wrap(
                  children: [
                    const Text('Defina o número máximo de integrantes (de 2 a 6): '),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF040268),
                        ),
                        onPressed: () {
                          if (numMaxParticipantes > 2){
                            setState(() {
                              numMaxParticipantes = numMaxParticipantes - 1;
                            });
                          }
                        }, 
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text("$numMaxParticipantes"),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF040268),
                        ),
                        onPressed: () {
                          if (numMaxParticipantes < 6){
                            setState(() {
                              numMaxParticipantes = numMaxParticipantes + 1;
                            });
                          }
                        }, 
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Criar grupo'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Não há nenhum grupo indo para ${widget.enderecoDestino} no momento... Deseja criar um novo grupo?",
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Lato',
                        ),
                      ),
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
                              builder: (BuildContext context, AsyncSnapshot<Usuario?> admnistradorSnapshot) {
                                if (admnistradorSnapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else {
                                  final grupo = Grupo.fromFirestore(
                                    document as DocumentSnapshot<Map<String, dynamic>>,
                                    null
                                  );
                                  return CardGrupo(
                                    grupo: grupo,
                                    nomeAdmin: admnistradorSnapshot.data!.nome,
                                    fotoAdmin: admnistradorSnapshot.data!.imagem,
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
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 90.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _showMyDialog,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 20.0),
                    backgroundColor: const Color(0xFF040268),
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Lato',
                      fontSize: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Criar novo grupo'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}