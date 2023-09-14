import 'package:flutter/material.dart';

class TelaEditaPerfil extends StatelessWidget {
  const TelaEditaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF040268),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 150,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/100x100'),
                  ),
                  Positioned(
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    bottom: -10,
                    left: 108,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Alterar foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                width: 273,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_document,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  label: const Text(
                    "Maria Luiza Pereira",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 16,
                      //fontWeight: FontWeight.medium
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Editar informações pessoais',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5453AF),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              )
            ],
          ),
        ));
  }
}
