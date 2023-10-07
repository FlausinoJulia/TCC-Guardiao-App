import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:guardiao_app/screens/boas_vindas.dart';
import 'package:guardiao_app/screens/perfil/contato_emergencia.dart';
import 'package:guardiao_app/screens/perfil/edita_info_pessoal.dart';
import 'package:guardiao_app/screens/perfil/edita_perfil.dart';
import 'package:guardiao_app/services/firebase_auth.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  //final _firebaseAuth = FirebaseAuth.instance;
  Usuario? usuario;

  @override
  void initState() {
    super.initState();
    pegarUsuario();
  }

  pegarUsuario() async {
    usuario = await Firestore.getUsuarioAtual();
    setState(() {});
    print (usuario!.nome);

    // if (usuario != null) {
    //   nome = usuario.nome;
    //   setState(() {
    //     nome = usuario.nome;
    //   });
    // }
  }

  Future<Widget> loadProfileImage() async {
    if (usuario != null && usuario!.imagem != "") {
      final imagemUrl = usuario!.imagem;
      final imagem = await FirebaseStorage.instance.ref(imagemUrl).getDownloadURL();
      return CircleAvatar(
        radius: 50,
        backgroundImage:  NetworkImage(imagem),
      );
    } else {
      return const CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Column(children: [
          Container(
              color: const Color(0xFF040268),
              height: 341.0,
              width: MediaQuery.of(context).size.width,
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
                  usuario == null ? "" : usuario!.nome,
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
                          builder: (context) => TelaEditaPerfil(dadosUsuario: usuario),
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
                onPressed: (){
                  logout();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const TelaBoasVindas()), 
                        (Route<dynamic> route) => false, // Remove todas as rotas anteriores da pilha.
                    );
                },
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
    );
  }
}
