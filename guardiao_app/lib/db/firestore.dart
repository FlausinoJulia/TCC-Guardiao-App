import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardiao_app/models/usuario.dart';

class Firestore {
   
  // adiciona um novo usuário no bd
  static Future<bool> criarUsuario(Usuario usuario) async {
    FirebaseFirestore.instance
      .collection('usuarios')
      .doc(usuario.uid)
      .set(usuario.toFirestore())
      .then((value) => true)
      .catchError((error) => false);
      return false;
  }

  // atualiza todas as infos do usuário
  static Future<bool> atualizarUsuario(String uid, Usuario dadosNovos) async {
    FirebaseFirestore.instance.collection('usuarios').doc(uid).update(dadosNovos.toFirestore())
      .then((value) {return true;})
      .onError((error, stackTrace) { return false; }); 
      return false;
  }

  // deletar o registro de um usuario
  static Future<bool> excluirUsuario(String uid) async {
    FirebaseFirestore.instance.collection('usuarios').doc(uid).delete()
      .then((value) => true)
      .onError((error, stackTrace) => false);
      return false;
  }

  // static Future<void> atualizarLocAtual(String uid, GeoPoint novaLoc) async {
  //   FirebaseFirestore.instance.collection('usuarios').doc(uid).update({'locAtual': {'latitude': novaLoc.latitude, 'longitude:' novaLoc.longitude}});
  // }
}