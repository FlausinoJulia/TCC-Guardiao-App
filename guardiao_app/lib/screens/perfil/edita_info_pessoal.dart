import 'package:flutter/material.dart';

class TelaInformacoesPessoais extends StatelessWidget {
  const TelaInformacoesPessoais({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 844,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      ),
    ),
      child: Stack(
        children: [
          Positioned(
            left: 64,
            top: 55,
            child: Transform(
              transform: Matrix4.identity(
                
              ),
            ),            
          )
        ],
      )
      );
  }
}