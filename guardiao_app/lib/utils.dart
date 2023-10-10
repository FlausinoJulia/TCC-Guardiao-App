import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage() async{
  final ImagePicker imagePicker = ImagePicker();
  XFile? imagem = await imagePicker.pickImage(source: ImageSource.gallery);
  return imagem;
}

Future<void> uploadImagem(String path, Usuario usuario) async {
  File file = File(path);

  try {
    String ref = 'imagens/img-${FirebaseAuth.instance.currentUser!.uid}.jpg';
    await FirebaseStorage.instance.ref(ref).putFile(file);

    usuario.imagem = ref;
    await Firestore.atualizarUsuario(usuario.uid, usuario);
  } catch (e) {
    print (e.toString());
  }
}