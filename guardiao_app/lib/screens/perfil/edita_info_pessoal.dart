import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/services/firebase_auth.dart';
import '../../db/firestore.dart';
import '../../models/usuario.dart';

class TelaInformacoesPessoais extends StatefulWidget {
  const TelaInformacoesPessoais({super.key});

  @override
  State<TelaInformacoesPessoais> createState() => _TelaInformacoesPessoais();
}

class _TelaInformacoesPessoais extends State<TelaInformacoesPessoais> {
  Usuario? usuario;

  // Talvez não precise dessa parte
  @override
  void initState() {
    super.initState();
    pegarUsuario();
  }

  pegarUsuario() async {
    usuario = await Firestore.getUsuarioAtual();
    setState(() {});
    print(usuario!.nome);
  }

  final userNameController = TextEditingController();
  final userNumberController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userEmailController = TextEditingController();

  Future<void> updateUserName(String newName) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .update({'nome': newName});

        print('Nome do usuário atualizado com sucesso!');
      } else {
        print('Usuário não autenticado.');
      }
    } catch (error) {
      print('Erro ao atualizar nome do usuário: $error');
    }
  }

  Future<void> updateUserNumber(String newNumber) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .update({'numero': newNumber});

        print('Número do usuário atualizado com sucesso!');
      } else {
        print('Usuário não autenticado.');
      }
    } catch (error) {
      print('Erro ao atualizar número do usuário: $error');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);

        print('Senha do usuário atualizada com sucesso!');
      } else {
        print('Usuário não autenticado.');
      }
    } catch (error) {
      print('Erro ao atualizar senha do usuário: $error');
    }
  }

  Future<void> updateUserEmail(String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateEmail(newEmail);

        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .update({'email': newEmail});

        print('Email do usuário atualizado com sucesso!');
      } else {
        print('Usuário não autenticado.');
      }
    } catch (error) {
      print('Erro ao atualizar email do usuário: $error');
    }
  }

  Widget buildEditableField(
    String label,
    String value,
    TextEditingController controller, {
      bool isPassword = false,
    }
  )
  {
    return ListTile(
      title: Text(label),
      subtitle: isPassword ? null : Text(value),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context){
              return AlertDialog(
                title: Text('Editar $label'),
                content: TextField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    hintText: 'Digite aqui...',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Atualiza o valor no campo correspondente
                      setState(() {
                        value = controller.text;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Salvar'),
                  ),
                ],
              );
            }
            );
        },
        ),
    );
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
                'Informações Pessoais',
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
            width: 300,
            height: 100,
            child: Text(
              'Essas são as suas informações pessoais, elas não ficam visíveis no seu perfil.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
          ),
          Container(
            width: 309,
            height: 380,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                buildEditableField('Nome', usuario!.nome, userNameController),
                buildEditableField('Número', usuario!.numero, userNumberController),
                buildEditableField('Email', usuario!.email, userEmailController),
                buildEditableField('Senha', usuario!.senha, userPasswordController, isPassword: true),
                ElevatedButton(
                  onPressed: () {
                    // Chamadas para atualizar os dados no Firebase
                    updateUserName(userNameController.text);
                    updateUserNumber(userNumberController.text);
                    updateUserEmail(userEmailController.text);
                    updatePassword(userPasswordController.text);
                  },
                  child: Text('Salvar Alterações'),
                ),
              ],
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
