import 'package:flutter/material.dart';
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
    );
  }
}              