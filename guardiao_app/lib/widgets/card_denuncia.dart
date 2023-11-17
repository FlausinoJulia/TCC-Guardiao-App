import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/models/denuncia.dart';
import 'package:guardiao_app/screens/denuncias/visualiza_denuncia.dart';

class CardDenuncia extends StatefulWidget {
  const CardDenuncia({
    super.key,
    required this.denuncia,
    required this.nomeUsuario,
    required this.fotoUsuario,
  });

  final Denuncia denuncia;
  final String nomeUsuario;
  final String fotoUsuario;

  @override
  State<CardDenuncia> createState() => _CardDenunciaState();
}

class _CardDenunciaState extends State<CardDenuncia> {

  @override
  void initState() {
    getImagem();
    super.initState();
  }

   Future<Widget> getImagem() async {
    if (widget.fotoUsuario != "") {
      final imagem = await FirebaseStorage.instance.ref(widget.fotoUsuario).getDownloadURL();
      return CircleAvatar(
        radius: 30,
        backgroundImage:  NetworkImage(imagem),
      );
    } else {
      return const CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg"),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TelaVisualizandoDenuncia(denuncia: widget.denuncia)));
        },
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 150.0,
            minHeight: 40.0,
            maxHeight: 182.0,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20),),
            color: Color(0xFFE9E9E9),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30),),
                  color: Color(0xFF6C6C6C)
                ),
                child: FutureBuilder<Widget> (
                  future: getImagem(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center (
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return snapshot.data!;
                    }
                  },
                ),
              ), 
              const SizedBox(width: 10.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nomeUsuario,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color:  Color(0xFF6C6C6C),
                      ),
                    ),
                    const Row (
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Color(0xFF040268),
                        ),
                        Text(
                          "Ver local da ocorrência",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Color(0xFF040268),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan (
                          text: (widget.denuncia.descricao.length > 170) ? widget.denuncia.descricao.substring(0, 165).trimRight() : widget.denuncia.descricao,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18.0,
                            color: Colors.black
                          ),
                          children: <TextSpan>[
                            if (widget.denuncia.descricao.length > 170) 
                              const TextSpan(text: "... ver mais", style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 18.0,
                                color: Color(0xFF040268),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}