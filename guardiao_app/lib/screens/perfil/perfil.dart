import 'package:flutter/material.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding (
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container (
                  color: const Color(0xFF040268),
                  height: 340.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, spreadRadius: 0.0, blurRadius: 10.0)
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect (
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        "foto", // colocar a foto do usuario
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const Text (
                      "nome do user",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        // fontWeight: medium,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white,),
                      onPressed: () {

                      }, 
                      child: const Text(
                        "Editar Perfil",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: Color(0xFF040268),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () {

              },
              icon: const Icon(
                Icons.info_outline,
                size: 20.0,
              ),
              label: const Text("Informações pessoais"),
            ),
            TextButton.icon(
              onPressed: () {
                
              },
              icon: const Icon(
                Icons.local_phone_outlined,
                size: 20.0,
              ),
              label: const Text("Meus contatos de emergência"),
            ),
            TextButton.icon(
              onPressed: () {

              },
              icon: const Icon(
                Icons.exit_to_app_rounded,
                color: Colors.red,
                size: 20.0,
              ),
              label: const Text(
                "Sair do aplicativo pessoais",
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Lato',
                  fontSize: 18.0,
                  //fontWeight: FontWeight.medium
                ),
              ),
            ),
          ],
        ),
      ),
    );          
  }
}