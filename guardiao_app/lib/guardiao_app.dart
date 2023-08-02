import 'package:flutter/material.dart';
import 'package:guardiao_app/telas/boas_vindas.dart';
import 'package:guardiao_app/telas/cadastro/cadastro_1.dart';
import 'package:guardiao_app/telas/inicio.dart';
import 'package:guardiao_app/telas/login.dart';
import 'package:guardiao_app/widgets/verifica_autenticacao.dart';

class GuardiaoApp extends StatefulWidget {
  const GuardiaoApp({super.key});

  @override
  State<GuardiaoApp> createState() => _GuardiaoAppState();
}

class _GuardiaoAppState extends State<GuardiaoApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Guardião COTUCA",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(4, 2, 104, 1.0), // mudar para primarySwatch
      ),
      home: const VerificaAutenticacao(),
      routes: {
        //'/':            (context) => const AuthCheck(),
        '/inicio':      (context) => const TelaInicial(),
        '/boas-vindas': (context) => const TelaBoasVindas(),
        '/login':       (context) => const TelaLogin(),
        '/cadastro':    (context) => const TelaCadastro(),
      },
    );
  }
}