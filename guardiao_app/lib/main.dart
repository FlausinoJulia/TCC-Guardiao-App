import 'package:flutter/material.dart';
import 'package:guardiao_app/telas/boas_vindas.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(4, 2, 104, 1.0),
      ),
      home: const TelaBoasVindas()
    );
  }
}
