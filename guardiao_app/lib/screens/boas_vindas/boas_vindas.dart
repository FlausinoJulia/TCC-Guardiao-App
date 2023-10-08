import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:guardiao_app/screens/cadastro/cadastro_1.dart';
import 'package:guardiao_app/screens/login/login.dart';

class TelaBoasVindas extends StatelessWidget {
  final String rota = '/boas-vindas';
  const TelaBoasVindas({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0, bottom: 30.0, right: 25.0, left: 25.0),
            child: Stack(
              children: <Widget>[
                Center (
                  child: Image.asset(
                    'assets/imagens/escudo.png', 
                    fit: BoxFit.fill,
                  )
                ),
                Column (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Guardião COTUCA",
                      style: TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Column (
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 268.0,
                            child: RichText(
                              text: const TextSpan(
                                text: "Aplicativo de segurança para alunos do ",
                                style: TextStyle(
                                  fontFamily: 'Be Vietnam Pro',
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "COTUCA", style: TextStyle(color: Colors.blueAccent))
                                ]
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TelaLogin(), 
                              ),
                            );
                          }, 
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width,55.0),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(15.0), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            )
                          ),
                          child: const Text(
                            "ENTRAR", 
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'Be Vietnam Pro',
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ),
                        const SizedBox(height: 15.0),
                        RichText(
                          text: TextSpan(
                            text: "Não possui uma conta? ",
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Cadastre-se", 
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const TelaCadastro(), 
                                      ),
                                    );
                                  },
                              )
                            ]
                          ), 
                        ),
                      ],
                    ),
                  ],
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}