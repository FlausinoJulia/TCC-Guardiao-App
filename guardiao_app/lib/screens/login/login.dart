import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/widgets/menu.dart';
import 'package:guardiao_app/services/firebase_auth.dart';
import 'package:guardiao_app/screens/cadastro/cadastro_1.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    "Bem-vindo de volta!",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(
                  'assets/imagens/escudo.png', 
                  fit: BoxFit.fill,
                  width: 35.0,
                  height: 42.78,
                ),
                Padding (
                  padding: const EdgeInsets.only(left:30.0, right: 30.0, top: 20.0, bottom: 20.0),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o email corretamente!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding (
                  padding: const EdgeInsets.only(left:30.0, right: 30.0, top: 20.0, bottom: 20.0),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe sua senha!';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool vaiNavegar = await login(emailController.text, senhaController.text, context);
                        if (vaiNavegar && context.mounted)
                        {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Menu()
                            ),
                          );
                        }
                      }
                    }, 
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 55.0),
                      backgroundColor: const Color(0x8F5453AF),
                      padding: const EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)
                      ),
                    ),
                    child: const Text(
                      "LOGIN", 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Esqueceu a senha? ",
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
                            ..onTap = (){
                              
                            },
                        )
                      ]
                    ), 
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Não tem uma conta? ",
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
          ),
        ),
      ),
    );
  }
}