import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';

import '../../models/usuario.dart';

class TelaInformacoesPessoais extends StatefulWidget {
  @override
  State<TelaInformacoesPessoais> createState() => _TelaInformacoesPessoais();
}

class _TelaInformacoesPessoais extends State<TelaInformacoesPessoais> {
    Usuario? dadosUsuario;

/*
    @override
  void initState() {
    super.initState();
    pegarUsuario();
  }

  pegarUsuario() async {
    dadosUsuario = await Firestore.getUsuarioAtual();
    setState(() {});
    print (dadosUsuario!.nome);
  }*/
    //await user?.updateDisplayName("Jane Q. User");
    //await user?.updatePhotoURL("https://example.com/jane-q-user/profile.jpg");

/*
    Future<void> editarNome(String nome) async{
      String novoNome = "";
      await showDialog(
        context: context;
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Editar nome",
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            style: TextStyle(
              color: Colors.white,
              decoration: InputDecoration(
                hintText: "Digite um novo nome",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              )
            ),
          ),
        ),
      );
    }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF040268),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                width: 40,
              ),
              const Text(
                'Informações Pessoais',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const SizedBox(
            width: 300,
            height: 100,
            child: Text(
              'Essas são as suas informações pessoais, elas não ficam visíveis no seu perfil.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
          ),
          Container(
            width: 309,
            height: 278,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      dadosUsuario == null ? "" : dadosUsuario!.nome,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 75,
                    ),
                    IconButton(
                        onPressed: () {
                          
                        },
                        icon: const Icon(
                          Icons.edit_document,
                          color: Colors.black,
                          size: 25.0,
                        )),
                  ],
                ),
                Container(
                  width: 310,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.2,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      dadosUsuario == null ? "" : dadosUsuario!.numero,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 108,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_document,
                          color: Colors.black,
                          size: 25.0,
                        )),
                  ],
                ),
                Container(
                  width: 310,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.2,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      dadosUsuario == null ? "" : dadosUsuario!.senha,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 148,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_document,
                          color: Colors.black,
                          size: 25.0,
                        )),
                  ],
                ),
                Container(
                  width: 310,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.2,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      dadosUsuario == null ? "" : dadosUsuario!.email,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 48,
                    ),
                    IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(
                          Icons.edit_document,
                          color: Colors.black,
                          size: 25.0,
                        )),
                  ],
                ),
              ],
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
        ],
      ),
      /* 
          Positioned(
            left: 80,
            top: 211,
            child: Text(
              'Maria Luiza Pereira',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(children: [
            Text(
              'Informações Pessoais',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
          Positioned(
            left: 37,
            top: 97,
            child: SizedBox(
              width: 326,
              child: Text(
                'Essas são as suas informações pessoais, elas não ficam visíveis no seu pergil.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          
          Positioned(
            left: 80,
            top: 277,
            child: Text(
              '19998174271',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 337,
            child: Text(
              '***********',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 396,
            child: Text(
              'cc21347@g.unicamp.br',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 294,
            top: 207,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/30x30"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 294,
            top: 273,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/30x30"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 294,
            top: 329,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/30x30"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 294,
            top: 392,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/30x30"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 39,
            top: 253,
            child: Container(
              width: 310,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 317,
            child: Container(
              width: 310,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 379,
            child: Container(
              width: 310,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 771,
            child: Container(
              width: 390,
              height: 73,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 390,
                      height: 73,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF040268),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        /*
                      border: Border.only(
                        left: BorderSide(),
                        top: BorderSide(),
                        right: BorderSide(),
                        bottom: BorderSide(width: 0.15),
                      ),
                      */
                      ),
                    ),
                  ),
                  Positioned(
                    left: 46,
                    top: 13,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 30,
                          child: Text(
                            'Início',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 6,
                          top: 0,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/22x22"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 119,
                    top: 14,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 29,
                          child: Text(
                            'Denúncias',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 22,
                          top: 0,
                          child: Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/23x23"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 224,
                    top: 16,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 27,
                          child: Text(
                            'Alarme',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 14,
                          top: 0,
                          child: Container(
                            width: 19,
                            height: 19,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/19x19"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 310,
                    top: 15,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 28,
                          child: Text(
                            'Perfil',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 6,
                          top: 0,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/22x22"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Maria Luiza Pereira',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Informações Pessoais',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Essas são as suas informações pessoais, elas não ficam visíveis no seu perfil.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '19998174271',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '***********',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'cc21232@g.unicamp.br',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Início',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Denúncias',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Alarme',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.20,
                    ),
                  ),
                  Text('Perfil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.20,
                      ))
                ],
              ),
            ),
            
          ),
        ],
      ),*/
    );
  }
}
