import 'package:flutter/material.dart';

class TelaContatoEmergencia extends StatelessWidget {
  const TelaContatoEmergencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        'Informações Pessoais',
        textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
          ),
      ),
      
    )
    ;
  }
}