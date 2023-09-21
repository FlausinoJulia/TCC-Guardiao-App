import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';

//import '../../models/usuario.dart';

//import '../../models/denuncia.dart';

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
      body: Center(
        child: Stack(
          children: [
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
                        return Card(
                          child: ListTile (
                            //leading: foto,
                            title: document['nomeUsuario'],
                            subtitle: document['descricao'],
                            //trailing: ,
                          ),
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
              child: ElevatedButton(
                
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF040268),
                  textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Lato',
                    fontSize: 18,
                  )

                ),
                child: const Text('Fazer uma denúncia'),
              ),
            )
          ],
        ),
      ),
    );
  }
}