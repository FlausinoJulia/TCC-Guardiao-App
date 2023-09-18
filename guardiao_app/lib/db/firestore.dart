import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_firestore_flutter/geo_firestore_flutter.dart';
import 'package:guardiao_app/models/usuario.dart';

import '../services/firebase_auth.dart';

class Firestore {

  // adiciona um novo usuário no bd
  static Future<bool> criarUsuario(Usuario usuario) async {
    FirebaseFirestore.instance
      .collection('usuarios')
      .doc(usuario.uid)
      .set(usuario.toFirestore())
      .then((value) => true)
      .catchError((error) => false);
      return true;
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
  
  
  static adicionarLocalizacao(String uid, GeoPoint loc) async {
    GeoFirestore localizacoes = GeoFirestore(FirebaseFirestore.instance.collection('localizacoes'));
    await localizacoes.setLocation(uid, loc);
  }

  static adicionarDestino(String uid, GeoPoint dest) async {
    GeoFirestore localizacoes = GeoFirestore(FirebaseFirestore.instance.collection('destinos'));
    await localizacoes.setLocation(uid, dest);
  }

  static Future<List<String>> getUsuariosComMesmoDestino(GeoPoint geoPoint) async {
    GeoFirestore localizacoes = GeoFirestore(FirebaseFirestore.instance.collection('destinos'));
    final queryLocation = geoPoint;
    
    List<String> grupo = [];
    String? idDoUsuarioAtual = getUid();

    final List<DocumentSnapshot> documents = await localizacoes.getAtLocation(queryLocation, 0);
    documents.forEach((document) {
      // print("DOCUMENTO: ${document.id}");
      if (document.id != idDoUsuarioAtual) grupo.add(document.id); // adicionando os usuarios que vao para o mesmo destino no grupo
    });

    return grupo;
  }
}