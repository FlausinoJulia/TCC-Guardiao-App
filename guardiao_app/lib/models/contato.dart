import 'package:cloud_firestore/cloud_firestore.dart';

class Contato {
  String nome;
  String numero;

  Contato({required this.nome, required this.numero});

  factory Contato.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options, 
  ) {
    final data = snapshot.data();
    return Contato (
      nome: data?['nome'],
      numero: data?['numero'],
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      "nome": nome,
      "numero": numero,
    };
  }
}