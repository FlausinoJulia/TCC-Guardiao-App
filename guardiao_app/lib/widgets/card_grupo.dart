import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/grupo.dart';
import 'package:guardiao_app/providers/provider_grupo.dart';
import 'package:guardiao_app/screens/grupos/visualiza_grupo.dart';
import 'package:provider/provider.dart';

class CardGrupo extends StatefulWidget {
  const CardGrupo({
    super.key,
    required this.grupoId,
    required this.grupo,
    required this.nomeAdmin,
    required this.fotoAdmin,
  });

  final String grupoId;
  final Grupo grupo;
  final String nomeAdmin;
  final String fotoAdmin;

  @override
  State<CardGrupo> createState() => _CardGrupoState();
}

class _CardGrupoState extends State<CardGrupo> {

  @override
  void initState() {
    getImagem();
    super.initState();
  }

   Future<Widget> getImagem() async {
    if (widget.fotoAdmin != "") {
      final imagem = await FirebaseStorage.instance.ref(widget.fotoAdmin).getDownloadURL();
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TelaVisualizandoGrupo(grupoId: widget.grupoId, grupo: widget.grupo)));
        },
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 150.0,
            minHeight: 145.0,
            maxHeight: 150.0,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20),),
            color: Color(0xFFE9E9E9),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
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
                          "Grupo de ${widget.nomeAdmin}",
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color:  Color(0xFF6C6C6C),
                          ),
                        ),
                        Text(
                          "${widget.grupo.integrantes.length}/${widget.grupo.numMaxParticipantes} pessoas",
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15.0
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF040268),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TelaVisualizandoGrupo(grupoId: widget.grupoId, grupo: widget.grupo)));
                      }, 
                      child: const Text(
                        "Ver integrantes"
                      ),
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF040268),
                      ),
                      onPressed: () async {
                        bool entrouNoGrupo = await Firestore.entrarNoGrupo(widget.grupoId);
                        if (entrouNoGrupo && context.mounted)
                        {
                          //Provider.of<GrupoProvider>(context).atualizaEstaEmGrupo(integrante: true, administrador: false);
                          Provider.of<GrupoProvider>(context, listen: false).atualizaEstaEmGrupo(integrante: true, administrador: false);
                          print("Eh integrante: ${Provider.of<GrupoProvider>(context).ehIntegrante}");
                          Navigator.of(context).pop();
                        }
                        else 
                        {
                          if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Não foi possível entrar no grupo!')));
                        }
                      }, 
                      child: const Text(
                        "Entrar no grupo",
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