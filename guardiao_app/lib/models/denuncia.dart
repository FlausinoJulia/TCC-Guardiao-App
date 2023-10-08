import 'package:cloud_firestore/cloud_firestore.dart';

class Denuncia {
  String uid;
  // String nomeUsuario;
  // String fotoUsuario;
  GeoPoint local;
  String endereco;
  String descricao;

  Denuncia ({
    required this.uid,
    // required this.nomeUsuario,
    // required this.fotoUsuario,
    required this.local,
    required this.endereco,
    required this.descricao,
  });

  factory Denuncia.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Denuncia(
      uid: data?['uid'],
      // nomeUsuario: data?['nomeUsuario'], 
      // fotoUsuario: data?['fotoUsuario'], 
      local: data?['local'], 
      endereco: data?['endereco'],
      descricao: data?['descricao'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      // "nomeUsuario": nomeUsuario,
      // "fotoUsuario": fotoUsuario,
      "local": local,
      "endereco": endereco,
      "descricao": descricao,
    };
  }
}