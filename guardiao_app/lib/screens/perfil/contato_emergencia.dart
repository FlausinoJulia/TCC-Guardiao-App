import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/usuario.dart';

class TelaContatoEmergencia extends StatefulWidget {
  @override
  State<TelaContatoEmergencia> createState() => _TelaContatoEmergencia();
}

class _TelaContatoEmergencia extends State<TelaContatoEmergencia> {
  List<Map<String, dynamic>> contactsData = List.generate(
    3,
    (index) => {'nome': '', 'numero': ''},
  );

  void salvarContatosDeEmergencia() async {
    // Verifica se todos os contatos foram preenchidos
    if (contactsData.every((contact) =>
        contact['name'] != null && contact['phone'] != null)) {
      // Obtém a referência do usuário atualmente autenticado
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Atualiza os contatos de emergência no Firestore
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .update({
          'contatosDeEmergencia': contactsData,
        });

        print('Contatos de emergência salvos com sucesso!');
      } else {
        print('Usuário não autenticado.');
      }
    } else {
      print('Por favor, preencha todos os campos de contato.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF040268),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                width: 40,
              ),
              const Text(
                'Contatos de Emergência',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const SizedBox(
            width: 340,
            height: 90,
            child: Text(
              'Esses contatos receberão uma mensagem de emergência quando você adicionar o botão de pânico.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
          ),
          const Text(
            'Informe até 3 contatos de emergência.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Form(
              key: null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: null,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.all(20.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  //width: 2.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                 // width: 2.5,
                                ),
                              ),
                              labelText: 'Nome',
                              labelStyle:
                                  const TextStyle(color: Colors.black),
                            ),
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Lato',
                                color: Colors.black),
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (!RegExp(r'^[a-z A-Z]+$')
                                    .hasMatch(value)) {
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
                              controller: null,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: const EdgeInsets.all(20.0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.5,
                                  ),
                                ),
                                labelText: 'Número',
                                labelStyle: const TextStyle(color: Colors.black),
                              ),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Lato',
                                color: Colors.black
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
                              controller: null,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: const EdgeInsets.all(20.0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.5,
                                  ),
                                ),
                                labelText: 'Nome',
                                labelStyle: const TextStyle(color: Colors.black),
                              ),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Lato',
                                color: Colors.black
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
                                controller: null,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.all(20.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2.5,
                                    ),
                                  ),
                                  labelText: 'Telefone',
                                  labelStyle: const TextStyle(color: Colors.black),
                                ),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Lato',
                                  color: Colors.black
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
                              controller: null,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: const EdgeInsets.all(20.0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.5,
                                  ),
                                ),
                                labelText: 'Nome',
                                labelStyle: const TextStyle(color: Colors.black),
                              ),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Lato',
                                color: Colors.black
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
                                controller: null,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.all(20.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2.5,
                                    ),
                                  ),
                                  labelText: 'Telefone',
                                  labelStyle: const TextStyle(color: Colors.black),
                                ),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Lato',
                                  color: Colors.black
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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // gerar lista de contatos do usuario para salvar no firestore
                           // List<Map<String, dynamic>> contatosDeEmergencia = gerarListaDeContatos();
          
                            // adicionando usuario no firebase auth
                            //await cadastrar(widget.email, widget.senha, context); 
/*
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
                            }*/
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width, 55.0),
                            backgroundColor: Color.fromARGB(143, 97, 97, 97),
                            padding: const EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                            ),
                          ),
                          child: const Text(
                            "SALVAR", 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            )
        ],
      ),
      /*
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              
              
            ]))
            */
    );
  }
}
