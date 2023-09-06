import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? uid; 
  String? nome;
  String? email;
  String? senha;
  String? numero;
  List<Map<String, dynamic>>? contatosDeEmergencia;
  GeoPoint? locAtual;

  Usuario ({
    this.uid,
    this.nome, 
    this.email, 
    this.senha, 
    this.numero, 
    this.contatosDeEmergencia,
    this.locAtual,
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usuario(
      uid: data?['uid'],
      nome: data?['nome'], 
      email: data?['email'], 
      senha: data?['senha'], 
      numero: data?['numero'], 
      contatosDeEmergencia: 
        data?['contatosDeEmergencia'] is Iterable? List.from(data?['contatosDeEmergencia']) : null, 
      locAtual: data?['locAtual'],
    );
  }  

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (nome != null) "nome": nome, 
      if (email != null) "email": email,
      if (senha != null) "senha": senha,
      if (numero != null) "numero": numero,
      if (contatosDeEmergencia != null) "contatosDeEmergencia": contatosDeEmergencia,
      if (locAtual != null) "locAtual": locAtual,                                                                              
    };
  }
}