import 'package:flutter/material.dart';

class TelaContatoEmergencia extends StatelessWidget {
  const TelaContatoEmergencia({super.key});

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
                                color: Colors.white),
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
