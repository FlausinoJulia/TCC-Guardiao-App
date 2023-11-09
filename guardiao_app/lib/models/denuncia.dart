import 'package:cloud_firestore/cloud_firestore.dart';

class Denuncia {
  String uid;
  GeoPoint local;
  String endereco;
  String descricao;

  Denuncia ({
    required this.uid,
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
      local: data?['local'], 
      endereco: data?['endereco'],
      descricao: data?['descricao'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "local": local,
      "endereco": endereco,
      "descricao": descricao,
    };
  }
}