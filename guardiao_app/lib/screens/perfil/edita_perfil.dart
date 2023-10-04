import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:guardiao_app/screens/perfil/perfil.dart';
import 'package:guardiao_app/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TelaEditaPerfil extends TelaPerfil {
  TelaEditaPerfil({super.key});

  Usuario? userModel;

  File? pickedImage;
  bool showLocalImage = false;

  pickImageFromDevice() async
  {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    pickedImage = File(file.path);

    showLocalImage = true;
    setState((){

    });

    // upload this image to firebase storage
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Uploading!!!'),
      message: const Text('Please wait'),
    );
    progressDialog.show();
    try{
      var fileName = userModel!.email! + '.jpg';

      UploadTask uploadTask = FirebaseStorage.instance.ref().child('profile_images').child(fileName).putFile(pickedImage!);

      TaskSnapshot snapshot = await uploadTask;

      String profileImageUrl = await snapshot.ref.getDownloadURL();

      print(profileImageUrl);

      progressDialog.dismiss();
    }
    catch(e){
      progressDialog.dismiss();

    }
  }

  /*
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<XFile?> getImage() async{
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<void> upload(String path) async{
    File file = File(path);
    try{
      final reference = storage.ref().child("images").child("img-${DateTime.now().toString()}.png");
      // String ref = 'images/img-${DateTime.now().toString()}.jpg';
      UploadTask uploadTask =  reference.putFile(file);
      String download = await (await uploadTask).ref.getDownloadURL();
    } on FirebaseException catch(e){
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  pickAndUploadImage() async{
    XFile? file = await getImage();
    if (file != null){
      await upload(file.path);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    //String imageUrl = '';
    return Scaffold(
        backgroundColor: const Color(0xFF040268),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaPerfil(),
                          ));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 150,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: showLocalImage == false ? NetworkImage(
                      
                      userModel!.image == "" ? 'https://static.vecteezy.com/ti/vetor-gratis/p3/3715527-imagem-perfil-icone-masculino-icone-humano-ou-pessoa-sinal-e-simbolo-vetor.jpg'
                        :
                        userModel!.image!
                    ): 

                      FileImage(pickedImage!) as ImageProvider,
                        //NetworkImage('image'),
                  ),
                  Positioned(
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: (){
                        pickImageFromDevice();
                      }
                      //pickAndUploadImage
                    ),
                    bottom: -10,
                    left: 108,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
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
              SizedBox(
                height: 32,
              ),
              Container(
                width: 273,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_document,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  label: const Text(
                    "Maria Luiza Pereira",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 16,
                      //fontWeight: FontWeight.medium
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
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
