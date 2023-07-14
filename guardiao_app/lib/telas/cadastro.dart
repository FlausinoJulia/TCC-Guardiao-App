import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/imagens/escudo.png', 
          fit: BoxFit.fill,
          width: 35.0,
          height: 42.78,
        ),
        const Text(
          "Preencha as informações abaixo", 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold
          )
        ),
        TextFormField(),
        TextFormField(),
        TextFormField(),
        TextFormField(),
        TextFormField(),
      ],
    );
  }
}