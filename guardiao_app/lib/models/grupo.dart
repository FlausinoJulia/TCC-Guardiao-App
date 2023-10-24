import 'package:cloud_firestore/cloud_firestore.dart';

class Grupo {
  String administrador;
  GeoPoint coordenadasDestino;
  String endereco;
  List<String> integrantes; // lista com UID dos participantes do grupo
  bool estaDisponivel;
  int numMaxParticipantes;

  Grupo({
    required this.administrador, 
    required this.coordenadasDestino, 
    required this.endereco,
    required this.integrantes,
    required this.estaDisponivel,
    required this.numMaxParticipantes
  });

  factory Grupo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options, 
  ) {
    final data = snapshot.data();
    return Grupo (
      administrador: data?['administrador'],
      coordenadasDestino: data?['coordenadasDestino'],
      endereco: data?['endereco'],
      integrantes: List.from(data?['integrantes']), 
      estaDisponivel: data?['estaDisponivel'],
      numMaxParticipantes: data?['numMaxParticipantes']
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      "administrador": administrador,
      "coordenadasDestino": coordenadasDestino,
      "endereco": endereco
    };
  }
}