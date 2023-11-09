import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String uid; 
  String nome;
  String email;
  String senha;
  String numero;
  String imagem;
  //bool estaDisponivel;
  List<Map<String, dynamic>>? contatosDeEmergencia;
  //GeoPoint locAtual;

  Usuario ({
    required this.uid,
    required this.nome, 
    required this.email, 
    required this.senha, 
    required this.numero, 
    required this.contatosDeEmergencia,
    //this.estaDisponivel,
    //this.locAtual,
    required this.imagem,
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
      imagem: data?['imagem'],
      // estaDisponivel: data['estaDisponivel'],
      contatosDeEmergencia: 
        data?['contatosDeEmergencia'] is Iterable? List.from(data?['contatosDeEmergencia']) : null, 
      //locAtual: data?['locAtual'],
    );
  }  

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "nome": nome, 
      "email": email,
      "senha": senha,
      "numero": numero,
      //"estaDisponivel": estaDisponivel,
      "contatosDeEmergencia": contatosDeEmergencia,
      //"locAtual": locAtual,       
      "imagem": imagem,                                                 
    };
  }
}