import 'package:flutter/material.dart';
import 'package:guardiao_app/screens/perfil/edita_perfil.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(children: [
          Column(children: [
            Container(
                color: const Color(0xFF040268),
                height: 341.0,
                width: 400,
                child: Column(children: [
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
                    height: 15,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://via.placeholder.com/100x100"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Maria Luiza Pereira',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF7F7F6),
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  /*
                  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width,55.0),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(15.0), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                          )
                        ),
                        
                      ),
                  */
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width, 50.0),
                        padding: const EdgeInsets.all(2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TelaEditaPerfil(),
                          ));
                    },
                    child: const Text(
                      'Editar Perfil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF02006C),
                        fontSize: 17,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ])),
          ]),
          SizedBox(
            height: 32,
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  label: const Text(
                    "Informações pessoais",
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'Lato', fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.local_phone_outlined,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  label: const Text(
                    "Meus contatos de emergência",
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'Lato', fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.red,
                    size: 18.0,
                  ),
                  label: const Text(
                    "Sair do aplicativo pessoais",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Lato',
                      fontSize: 18,
                      //fontWeight: FontWeight.medium
                    ),
                  ),
                ),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
