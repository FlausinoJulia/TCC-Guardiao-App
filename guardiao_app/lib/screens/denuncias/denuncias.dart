import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/denuncia.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:guardiao_app/widgets/card_denuncia.dart';

import 'fazendo_denuncia.dart';

class TelaDenuncias extends StatefulWidget {
  const TelaDenuncias({super.key});

  @override
  State<TelaDenuncias> createState() => _TelaDenunciasState();
}

class _TelaDenunciasState extends State<TelaDenuncias> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Central de Denúncias",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Lato',
              
                  ),
                ),
              ),
              StreamBuilder(
                stream: Firestore.getDenuncias(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center (
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Expanded(
                      child: Center (
                        child: Text("Nenhuma denúncia encontrada..."),
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
                                future: Firestore.getUsuario(document['uid']),
                                builder: (BuildContext context, AsyncSnapshot<Usuario?> userSnapshot) {
                                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else {
                                    final denuncia = Denuncia.fromFirestore(
                                      document as DocumentSnapshot<Map<String, dynamic>>,
                                      null
                                    );
                                    return CardDenuncia(
                                      denuncia: denuncia,
                                      nomeUsuario: userSnapshot.data!.nome,
                                      //descricao: document['descricao'],
                                      fotoUsuario: userSnapshot.data!.imagem
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
                height: 105.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const TelaFazendoDenuncia()),
                      );
                    },
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
                    child: const Text('Fazer uma denúncia'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}