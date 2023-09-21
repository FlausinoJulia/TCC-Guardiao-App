import 'package:cloud_firestore/cloud_firestore.dart';

class Denuncia {
  String nomeUsuario;
  String fotoUsuario;
  GeoPoint local;
  String descricao;

  Denuncia ({
    required this.nomeUsuario,
    required this.fotoUsuario,
    required this.local,
    required this.descricao,
  });

  factory Denuncia.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Denuncia(
      nomeUsuario: data?['nomeUsuario'], 
      fotoUsuario: data?['fotoUsuario'], 
      local: data?['local'], 
      descricao: data?['descricao'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nomeUsuario": nomeUsuario,
      "fotoUsuario": fotoUsuario,
      "local": local,
      "descricao": descricao,
    };
  }
}