import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:guardiao_app/screens/boas_vindas/boas_vindas.dart';
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(
                  height: 18,
                ),
                Text(
                  usuario == null ? "" : usuario!.nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFF7F7F6),
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(210, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TelaEditaPerfil(dadosUsuario: usuario),
                        )).then((_) => setState(() {}));
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
        const SizedBox(
          height: 32,
        ),
        Align(
          child: Row(
            children: [
              const SizedBox(width: 35,),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TelaInformacoesPessoais(),
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
                const SizedBox(width: 35,),
                TextButton.icon(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TelaContatoEmergencia(),
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
                const SizedBox(width: 35,),
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
                  ),
                ),
              ),
              ]),
          )
        
      ]),
    );
  }
}
