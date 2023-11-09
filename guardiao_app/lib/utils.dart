import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:guardiao_app/services/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

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

Future<LatLng> getLocalizacaoAtual() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Serviços de localização desativados.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission==LocationPermission.denied) {
        return Future.error('Permissão para localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão para localização negada para sempre.');
    }

    Position pos = await Geolocator.getCurrentPosition();

    String uid = getUid()!;
    Firestore.adicionarLocalizacao(uid, GeoPoint(pos.latitude, pos.longitude));

    LatLng latLng = LatLng(pos.latitude, pos.longitude);
    return latLng;
  }