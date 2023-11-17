import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    if (contactsData.every(
        (contact) => contact['name'] != null && contact['phone'] != null)) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < contactsData.length; i++)
                ContactForm(
                  contactData: contactsData[i],
                  onChanged: (data) {
                    setState(() {
                      contactsData[i] = data;
                    });
                  },
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: salvarContatosDeEmergencia,
                child: Text('Salvar Contatos de Emergência'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactForm extends StatelessWidget {
  final Map<String, dynamic> contactData;
  final ValueChanged<Map<String, dynamic>> onChanged;

  ContactForm({required this.contactData, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    onChanged({
                      'name': value,
                      'phone': contactData['phone'],
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Nome',
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    onChanged({
                      'name': contactData['name'],
                      'phone': value,
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Telefone',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
    /*
    return Column(
      children: [
        /*
        Text(
          'Contato de Emergência',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),*/
        TextField(
          onChanged: (value) {
            onChanged({
              'nome': value,
              'numero': contactData['numero'],
            });
          },
          decoration: InputDecoration(
            hintText: 'Nome',
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          onChanged: (value) {
            onChanged({
              'nome': contactData['nome'],
              'numero': value,
            });
          },
          decoration: InputDecoration(
            hintText: 'Telefone',
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }*/
}
