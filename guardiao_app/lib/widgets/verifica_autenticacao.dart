import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/screens/boas_vindas.dart';
//import 'package:guardiao_app/screens/boas_vindas.dart';
import 'package:guardiao_app/screens/inicio.dart';
//import 'package:guardiao_app/screens/perfil/perfil.dart';


class VerificaAutenticacao extends StatefulWidget {
  const VerificaAutenticacao({super.key});

  @override
  State<VerificaAutenticacao> createState() => _VerificaAutenticacaoState();
}

class _VerificaAutenticacaoState extends State<VerificaAutenticacao> {

  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    streamSubscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => const TelaBoasVindas()
          ),
        );
      } else {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => const TelaInicial()
          ),
        );
      }
    });
  }

   @override
    void dispose() {
      streamSubscription!.cancel();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}