import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String? getUid() {
  return FirebaseAuth.instance.currentUser?.uid;
}

Future<bool> cadastrar(String email, String senha, BuildContext context) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, 
      password: senha
    );
    
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('A senha deve conter ao menos 6 caracteres!')));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Este email já está cadastrado.')));
    } else if (e.code == 'invalid-email') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Email inválido.')));
    } else {
      print("email: ${email}");
      print (e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Falha ao fazer o cadastro. Tente novamente!')));
    }
    return false;
  }
}

Future<bool> login(String email, String senha, BuildContext context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: senha
    );
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('A senha deve conter ao menos 6 caracteres!')));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Este email já está cadastrado.')));
    }
    return false;
  }
}