import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/widgets/card_denuncia.dart';

class TelaDenuncias extends StatefulWidget {
  const TelaDenuncias({super.key});

  @override
  State<TelaDenuncias> createState() => _TelaDenunciasState();
}

class _TelaDenunciasState extends State<TelaDenuncias> {
  //late List<Denuncia> denuncias;

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
                  else if (!snapshot.hasData) {
                    return const Center (
                      child: Text("Nenhuma denúncia encontrada."),
                    );
                  }
                  else {
                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.docs.map((document) {
                          return CardDenuncia(
                            nomeUsuario: document['nomeUsuario'], 
                            descricao: document['descricao'],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}