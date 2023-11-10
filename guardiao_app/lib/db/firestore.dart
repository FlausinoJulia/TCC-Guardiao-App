import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_firestore_flutter/geo_firestore_flutter.dart';
import 'package:guardiao_app/models/contato.dart';
import 'package:guardiao_app/models/denuncia.dart';
import 'package:guardiao_app/models/grupo.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:latlong2/latlong.dart';

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

  static Future<Usuario?> getUsuarioAtual() async {
    String? uid = getUid();
    if (uid != null) {
      final ref = FirebaseFirestore.instance.collection('usuarios').doc(uid).withConverter(
        fromFirestore: Usuario.fromFirestore, 
        toFirestore: (Usuario usuario, _) => usuario.toFirestore(),
      );

      final docSnap = await ref.get();

      final usuario = docSnap.data();
    
      return usuario;    
    }
    else {
      return null;
    }
  }
  
  static Future<Usuario?> getUsuario(String uid) async {
    final ref = FirebaseFirestore.instance.collection('usuarios').doc(uid).withConverter(
      fromFirestore: Usuario.fromFirestore, 
      toFirestore: (Usuario usuario, _) => usuario.toFirestore(),
    );

    final docSnap = await ref.get();

    final usuario = docSnap.data();

    return usuario;    
  }

  static Future<List<Contato>> getContatosDeEmergencia(String uid) async {
    List<Contato> contatosDeEmergencia = [];

    final userDoc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();

    if (userDoc.exists) {
      final data = userDoc.data();
      if (data != null) {
        final contatos = data['contatosDeEmergencia'];
        if (contatos != null && contatos is List) {
          for (var contatoData in contatos) {
            final contato = Contato.fromFirestore(
              contatoData,
              null
            );
            contatosDeEmergencia.add(contato);
          }
        }
      }
    }

    return contatosDeEmergencia;
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

  // static Future<List<String>> getUsuariosComMesmoDestino(GeoPoint geoPoint) async {
  //   GeoFirestore localizacoes = GeoFirestore(FirebaseFirestore.instance.collection('destinos'));
  //   final queryLocation = geoPoint;
    
  //   List<String> grupo = [];
  //   String? idDoUsuarioAtual = getUid();

  //   final List<DocumentSnapshot> documents = await localizacoes.getAtLocation(queryLocation, 0);
  //   for (var document in documents) {
  //     // print("DOCUMENTO: ${document.id}");
  //     if (document.id != idDoUsuarioAtual) grupo.add(document.id); // adicionando os usuarios que vao para o mesmo destino no grupo
  //   }

  //   // verificar se todos os usuarios da lista estao disponiveis para formar o grupo

  //   return grupo;
  // }

  // denuncias  
  static Stream<QuerySnapshot<Map<String, dynamic>>> getDenuncias() {
    return FirebaseFirestore.instance.collection('denuncias').snapshots();
  }

  static Future<bool> salvarDenuncia(Denuncia denuncia) async {
    await adicionarPontoDePerigo(denuncia.local);
    FirebaseFirestore.instance
      .collection('denuncias')
      .add(denuncia.toFirestore())
      .then((value) => true)
      .catchError((error) => false);
      return true;
  }

  // grupos
  static Stream<QuerySnapshot<Map<String, dynamic>>> getGrupos() {
    return FirebaseFirestore.instance.collection('grupos').snapshots();
  }

  static Future<bool> criarGrupo(Grupo grupo) async {
    FirebaseFirestore.instance
      .collection('grupos')
      .add(grupo.toFirestore())
      .then((value) => true)
      .catchError((error) => false);
      return true;
  }

  static Future<bool> entrarNoGrupo (String grupoId) async {
    String? usuarioAtual = getUid();

    if (usuarioAtual != null) {

      final grupoRef = FirebaseFirestore.instance
                      .collection('grupos')
                      .doc(grupoId);

      grupoRef.update({
        "integrantes": FieldValue.arrayUnion([usuarioAtual]),
      });

      return true;
    } 

    return false;
  } 

  // zonas de perigo
  static Future<void> adicionarPontoDePerigo(GeoPoint geoPoint) async {
    await FirebaseFirestore.instance
      .collection('pontos_de_perigo')
      .add({'coordenada': geoPoint})
      .then((value) => true)
      .catchError((error) => false);
  }

  static Future<List<LatLng>> getPontosDePerigo() async {
    List<LatLng> zonasDePerigo = [];

    final snapshot = await FirebaseFirestore.instance.collection('pontos_de_perigo').get();
    for (QueryDocumentSnapshot document in snapshot.docs) {
      GeoPoint geoPoint = document['coordenada'] as GeoPoint;
      double latitude = geoPoint.latitude;
      double longitude = geoPoint.longitude;
      LatLng latLng = LatLng(latitude, longitude);
      zonasDePerigo.add(latLng);
    }

    return zonasDePerigo;
  }
}