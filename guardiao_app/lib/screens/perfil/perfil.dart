import 'package:flutter/material.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                  children: [ 
                    IconButton (
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                      },
                    ),
                  ]
                ),
                  Container(
                    color: const Color(0xFF040268),
                    height: 341.0,
                    width: 390,
                    /*
                  decoration: BoxDecoration(
                    color: Color(0xFF02006C),
                    /*
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    ),
                    ),
                    */
                  ),
                  */
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 390,
                        height: 341,
                        decoration: ShapeDecoration(
                          color: Color(0xFF02006C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      /*
                      Container(
                        width: 100,
                        height: 100,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://via.placeholder.com/100x100"),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      */
                      const Text(
                        "Danyelle",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          // fontWeight: medium,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {},
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
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  size: 20.0,
                ),
                label: const Text(
                  "Informações pessoais",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Lato', fontSize: 18.8),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.local_phone_outlined,
                  color: Colors.black,
                  size: 20.0,
                ),
                label: const Text(
                  "Meus contatos de emergência",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Lato', fontSize: 18.8),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
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
        ));
  }
}