import 'package:flutter/material.dart';

class TelaContatoEmergencia extends StatelessWidget {
  const TelaContatoEmergencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Text(
            'Contatos de emergência',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w500,
            ),
            ),
            Text(
                'oi'
            ),
      ]
      ),
      
    ))
    ;
  }
}