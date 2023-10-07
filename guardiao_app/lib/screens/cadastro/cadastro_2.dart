import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/models/contato.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/screens/login.dart';
import 'package:guardiao_app/screens/menu.dart';
import 'package:guardiao_app/services/firebase_auth.dart';

class TelaCadastro2 extends StatefulWidget {
  final String nome;
  final String email;
  final String senha;
  final String numero;

  const TelaCadastro2({
    super.key, 
    required this.nome, 
    required this.email,
    required this.senha,
    required this.numero,
  });

  @override
  State<TelaCadastro2> createState() => _TelaCadastro2State();
}

class _TelaCadastro2State extends State<TelaCadastro2> {
  final _formKey = GlobalKey<FormState>();
  final contatoUmController = TextEditingController();
  final contatoDoisController = TextEditingController();
  final contatoTresController = TextEditingController();
  final numeroUmController = TextEditingController();
  final numeroDoisController = TextEditingController();
  final numeroTresController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040268),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                Row(
                  children: [ 
                    IconButton (
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // tem que voltar o user?
                      },
                    ),
                    const SizedBox(width: 15.0,),
                    const Text(
                      "Contatos de emergência",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold)
                    ),
                  ]
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Esses contatos receberão uma mensagem de emergência se o botão de pânico for acionado.",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Informe até 3 contatos de emergência.",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                      
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row (
                          children: [
                            Expanded(
                              child: TextFormField (
                                controller: contatoUmController,
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
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                      return "Nome inválido!";
                                    }
                                    return null;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField (
                                controller: numeroUmController,
                                keyboardType: TextInputType.phone,
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
                                  labelText: 'Número',
                                  labelStyle: const TextStyle(color: Colors.white),
                                ),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Lato',
                                  color: Colors.white
                                ),
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    if (value.length < 11) {
                                      return "Número de celular inválido!";
                                    }
                                    return null;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row (
                          children: [
                            Expanded(
                              child: TextFormField (
                                controller: contatoDoisController,
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
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                      return "Nome inválido!";
                                    }
                                    return null;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField (
                                  controller: numeroDoisController,
                                  keyboardType: TextInputType.phone,
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
                                  validator: (value) {
                                    if (value!.isNotEmpty) {
                                      if (value.length < 11) {
                                        return "Número de celular inválido!";
                                      }
                                      return null;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row (
                          children: [
                            Expanded(
                              child: TextFormField (
                                controller: contatoTresController,
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
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                      return "Nome inválido!";
                                    }
                                    return null;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField (
                                  controller: numeroTresController,
                                  keyboardType: TextInputType.phone,
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
                                  validator: (value) {
                                    if (value!.isNotEmpty) {
                                      if (value.length < 11) {
                                        return "Número de celular inválido!";
                                      }
                                      return null;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                            ),
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Esses campos não são obrigatórios e podem ser configurados posteriormente.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // gerar lista de contatos do usuario para salvar no firestore
                            List<Map<String, dynamic>> contatosDeEmergencia = gerarListaDeContatos();
          
                            // adicionando usuario no firebase auth
                            await cadastrar(widget.email, widget.senha, context); 

                            String? uid = getUid();
                            if (uid != null && context.mounted)
                            {
                              Usuario usuario = Usuario(
                                uid: uid, 
                                nome: widget.nome, 
                                email: widget.email, 
                                senha: widget.senha, 
                                numero: widget.numero, 
                                contatosDeEmergencia: contatosDeEmergencia, 
                                imagem: ""
                              );
                              
                              bool vaiNavegar = await Firestore.criarUsuario(usuario);
                              if(vaiNavegar && context.mounted) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const Menu())
                                );
                              }
                              else {
                                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Falha ao fazer o cadastro. Tente novamente!')));
                              }
                            } else {
                              if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Falha ao fazer o cadastro. Tente novamente!')));
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
                            "CADASTRAR", 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500
                            ),
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
          ),
        ),
      )
    );
  }
  
  List<Map<String, dynamic>> gerarListaDeContatos() {
    List<Map<String, dynamic>> contatos = [];

    Contato contatoUm = Contato(
      nome: contatoUmController.text.toString().trim(), 
      numero: numeroUmController.text.toString().trim()
    );
    contatos.add(contatoUm.toFirestore());

    Contato contatoDois = Contato(
      nome: contatoDoisController.text.toString().trim(), 
      numero: numeroDoisController.text.toString().trim()
    );
    contatos.add(contatoDois.toFirestore());

    Contato contatoTres = Contato(
      nome: contatoTresController.text.toString().trim(), 
      numero: numeroTresController.text.toString().trim()
    );
    contatos.add(contatoTres.toFirestore());


    return contatos;
  }
}
