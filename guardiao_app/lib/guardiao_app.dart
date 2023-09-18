import 'package:flutter/material.dart';
import 'package:guardiao_app/screens/perfil/contato_emergencia.dart';
import 'package:guardiao_app/screens/perfil/edita_info_pessoal.dart';
import 'package:guardiao_app/screens/perfil/edita_perfil.dart';
import 'package:guardiao_app/screens/perfil/perfil.dart';

// import 'package:guardiao_app/screens/denuncias/denuncias.dart';
// import 'package:guardiao_app/screens/boas_vindas.dart';
// import 'package:guardiao_app/screens/cadastro/cadastro_1.dart';
// import 'package:guardiao_app/screens/inicio.dart';
// import 'package:guardiao_app/screens/login.dart';
// import 'package:guardiao_app/screens/perfil/edita_perfil.dart';
// import 'package:guardiao_app/screens/perfil/perfil.dart';
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
      home: const TelaEditaPerfil(),
      // routes: {
      //   //'/':            (context) => const AuthCheck(),
      //   '/inicio':      (context) => const TelaInicial(),
      //   '/boas-vindas': (context) => const TelaBoasVindas(),
      //   '/login':       (context) => const TelaLogin(),
      //   '/cadastro':    (context) => const TelaCadastro(),
      // },
    );
  }
}              