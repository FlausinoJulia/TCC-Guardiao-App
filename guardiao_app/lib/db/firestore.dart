import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardiao_app/models/usuario.dart';

class Firestore {
  CollectionReference _usuarios = FirebaseFirestore.instance.collection('usuarios');
  
  Future<void> criarUsuario(Usuario usuario) async {
    _usuarios.doc(usuario.uid).set(usuario.toFirestore())
      .then((value) => print("Usuario adicionado"))
      .catchError((error) => print("Failed to "));
  }

// atualizar telefone, nome, senha, email
  Future<void> atualizar(Usuario usuario, String campo, String valor, int indice) async {
    final refUsuario = db.collection("usuarios").doc(usuario.uid);

    if (campo != "contatosDeEmergencia") {
      refUsuario.update({"${campo}": valor}).then(
        (value) => print("DocumentSnapshot sucessfully updated!"),
        onError: (e) => print("Failed to add user: ${e}")
      );
    }
    else {
      /*String numeroAntigo = usuario.contatosDeEmergencia!.elementAt(indice);
      refUsuario.update({
        "${campo}": FieldValue.arrayRemove([numeroAntigo]),
      });*/
    }
  }
}