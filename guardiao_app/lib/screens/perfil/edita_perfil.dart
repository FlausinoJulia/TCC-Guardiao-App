import 'package:flutter/material.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:guardiao_app/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TelaEditaPerfil extends StatefulWidget {
  final Usuario? dadosUsuario;
  const TelaEditaPerfil({super.key, required this.dadosUsuario});

  @override
  State<TelaEditaPerfil> createState() => _TelaEditaPerfilState();
}

class _TelaEditaPerfilState extends State<TelaEditaPerfil> {

  pickAndUploadImage() async {
    XFile? file = await pickImage();
    if (file != null) {
      await uploadImagem(file.path, widget.dadosUsuario!);
    }
    setState(() {});
  }

  Future<Widget> loadProfileImage() async {
    if (widget.dadosUsuario != null && widget.dadosUsuario!.imagem != "") {
      final imagemUrl = widget.dadosUsuario!.imagem;
      final imagem = await FirebaseStorage.instance.ref(imagemUrl).getDownloadURL();
      return CircleAvatar(
        radius: 80,
        backgroundImage:  NetworkImage(imagem),
      );
    } else {
      return const CircleAvatar(
        radius: 80,
        backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF040268),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 150,
              ),
              Stack(
                children: [
                  FutureBuilder<Widget>(
                    future: loadProfileImage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return snapshot.data!;
                      }
                    },
                  ),
                  Positioned(
                    bottom: -10,
                    left: 108,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: (){
                        pickAndUploadImage();
                        setState(() {});
                      }
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Alterar foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const SizedBox(height: 32,),
              Container(
                width: 273,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_document,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    label: Text(
                      widget.dadosUsuario!.nome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Editar informações pessoais',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5453AF),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              )
            ],
          ),
        ));
  }
}
