import 'package:cloud_firestore/cloud_firestore.dart';

class Grupo {
  String administrador;
  GeoPoint endereco;
  String endereco;

  Contato({required this.nome, required this.numero});

  factory Contato.fromFirestore(
    Map<String, dynamic> snapshot,
    SnapshotOptions? options, 
  ) {
    //final data = snapshot.data();
    return Contato (
      nome: snapshot['nome'],
      numero: snapshot['numero'],
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      "nome": nome,
      "numero": numero,
    };
  }
}