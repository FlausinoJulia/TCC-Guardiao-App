import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardiao_app/models/usuario.dart';

class Firestore {
   
  // adiciona um novo usuário no bd
  static Future<void> criarUsuario(Usuario usuario) async {
    FirebaseFirestore.instance
      .collection('usuarios')
      .doc(usuario.uid)
      .set(usuario.toFirestore())
      .then((value) => print("Usuario adicionado"))
      .catchError((error) => print("Failed to "));
  }

  // atualiza todas as infos do usuário
  static Future<void> atualizarUsuario(String uid, Usuario dadosNovos) async {
    FirebaseFirestore.instance.collection('usuarios').doc(uid).update(dadosNovos.toFirestore()); // onFailure e onSucess
  }

  // deletar o registro de um usuario
  static Future<void> excluirUsuario(String uid) async {
    FirebaseFirestore.instance.collection('usuarios').doc(uid).delete();
  }
}