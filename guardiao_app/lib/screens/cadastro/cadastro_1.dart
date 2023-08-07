import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:guardiao_app/screens/inicio.dart';
import 'package:guardiao_app/screens/login.dart';

import 'cadastro_2.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();
  final telefoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040268),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset(
                  'assets/imagens/escudo.png',
                  fit: BoxFit.fill,
                  width: 35.0,
                  height: 42.78,
                ),
              ),
              const Text(
                "Preencha as informações abaixo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold)
              ),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  key: _formKey,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      child: TextFormField(
                        controller: nomeController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                          labelText: 'Nome',
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          color: Colors.white
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),                   
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          color: Colors.white
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      child: TextFormField(
                        controller: senhaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                          labelText: 'Senha',
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          color: Colors.white
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      child: TextFormField(
                        controller: confirmaSenhaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                          labelText: 'Confirme a senha',
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          color: Colors.white
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      child: TextFormField(
                        controller: telefoneController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                          labelText: 'Telefone',
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          color: Colors.white
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TelaCadastro2(), 
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width, 55.0),
                          backgroundColor: const Color(0x8F5453AF),
                          padding: const EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ 
                            Text(
                              "AVANÇAR", 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Icon(Icons.arrow_forward)
                          ]
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Já tem uma conta? ",
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Clique aqui",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TelaLogin(), 
                                ),
                              );
                            },
                          )
                        ]
                      ),
                    ),
                  ]
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
