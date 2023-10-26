import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/usuario.dart';

class CardIntegrante extends StatefulWidget {
  const CardIntegrante({super.key, required this.uid});

  final String uid;

  @override
  State<CardIntegrante> createState() => _CardIntegranteState();
}

class _CardIntegranteState extends State<CardIntegrante> {


  @override
  void initState() {
    super.initState();
  }

  Future<Usuario?> getUsuarioAtual () async {
    return await Firestore.getUsuario(widget.uid); 
  }

  Future<Widget> getImagem(Usuario usuario) async {
    if (usuario.imagem != "") {
      final imagem = await FirebaseStorage.instance.ref(usuario.imagem).getDownloadURL();
      return CircleAvatar(
        radius: 25,
        backgroundImage:  NetworkImage(imagem),
      );
    } else {
      return const CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: FutureBuilder<Usuario?>(
        future: getUsuarioAtual(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            Usuario user = snapshot.data!;
            return Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    FutureBuilder<Widget> (
                      future: getImagem(user),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center (
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return snapshot.data!;
                        }
                      },
                    ),
                    const SizedBox(width: 20.0,),
                    Text(
                      user.nome,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
              )
            );
          } else {
            return Container();
          }
        },
        
      ),
    );
  }
}