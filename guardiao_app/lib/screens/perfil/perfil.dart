import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guardiao_app/screens/perfil/contato_emergencia.dart';
import 'package:guardiao_app/screens/perfil/edita_info_pessoal.dart';
import 'package:guardiao_app/screens/perfil/edita_perfil.dart';
import 'package:guardiao_app/widgets/verifica_autenticacao.dart';

class TelaPerfil extends StatelessWidget {
  TelaPerfil({super.key});

  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';

  @override
  InitState(){
    pegarUsuario();
  }

  pegarUsuario() async{
    User? usuario = await _firebaseAuth.currentUser;

    // arrumar isso aqui
    /*
    if(usuario != null){
      setState((){
        nome = usuario.displayName!;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(children: [
          Column(children: [
            Container(
                color: const Color(0xFF040268),
                height: 341.0,
                width: 400,
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://via.placeholder.com/100x100'),
                      ),
                    ],
                  ),
                  /*
                  Container(
                    width: 100,
                    height: 100,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://via.placeholder.com/100x100"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                  ),
                  */
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    nome,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF7F7F6),
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(210, 45),
                        //fixedSize:
                            //Size(MediaQuery.of(context).size.longestSide, 50.0),
                        // padding: const EdgeInsets.all(2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaEditaPerfil(),
                          ));
                    },
                    child: const Text(
                      'Editar Perfil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF02006C),
                        fontSize: 17,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ])),
          ]),
          SizedBox(
            height: 32,
          ),
          Align(
            child: Row(
              children: [
                SizedBox(width: 35,),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TelaInformacoesPessoais(),
                          ));
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: 25.0,
                  ),
                  label: const Text(
                    "Informações pessoais",
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'Lato', fontSize: 18),
                  ),
                ),
              ],),
            ),
            Align(
              child: Row(
                children: [
                  SizedBox(width: 35,),
                  TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TelaContatoEmergencia(),
                          ));
                  },
                  icon: const Icon(
                    Icons.local_phone_outlined,
                    color: Colors.black,
                    size: 25.0,
                  ),
                  label: const Text(
                    "Meus contatos de emergência",
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'Lato', fontSize: 18),
                  ),
                ),
                ]),
            ),
            Align(
              child: Row(
                children: [
                  SizedBox(width: 35,),
                  TextButton.icon(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.red,
                    size: 25.0,
                  ),
                  label: const Text(
                    "Sair do aplicativo",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Lato',
                      fontSize: 18,
                      //fontWeight: FontWeight.medium
                    ),
                  ),
                ),
                ]),
            )
          
        ]),
      ),
    );
  }
}
