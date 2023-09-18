import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:guardiao_app/screens/perfil/perfil.dart';
import 'package:guardiao_app/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TelaEditaPerfil extends StatelessWidget {
  const TelaEditaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
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
                            builder: (context) => const TelaPerfil(),
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
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/100x100'),
                  ),
                  Positioned(
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async{
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                        print('${file?.path}');

                        if(file==null) return;

                        // isso aqui não sei se precisa pq é da galeria e não cammera
                        String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                        // Get a reference to storage root
                        Reference referenceRoot = FirebaseStorage.instance.ref();
                        Reference referenceDirImages = referenceRoot.child('images');
                      
                        // reate a reference for the image to be stored
                        //Reference referenceImageToUpload = referenceDirImages.child('${file?.name}');
                        Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

                        // Handle errors/sucess
                        try{
                          // Store the file
                          await referenceImageToUpload.putFile(File(file.path));
                          // Sucess: get the dowload URL
                          imageUrl = await referenceImageToUpload.getDownloadURL();
                        }catch(error){
                          // Some error ocurred
                        }
                      },
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
