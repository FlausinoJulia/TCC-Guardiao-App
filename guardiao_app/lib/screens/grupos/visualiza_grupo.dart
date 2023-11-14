import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/grupo.dart';
import 'package:guardiao_app/providers/provider_grupo.dart';
import 'package:guardiao_app/widgets/card_integrante.dart';
import 'package:guardiao_app/widgets/menu.dart';
import 'package:provider/provider.dart';

class TelaVisualizandoGrupo extends StatefulWidget {
  const TelaVisualizandoGrupo({super.key, required this.grupoId, required this.grupo});

  final String grupoId;
  final Grupo grupo;

  @override
  State<TelaVisualizandoGrupo> createState() => _TelaVisualizandoGrupoState();
}

class _TelaVisualizandoGrupoState extends State<TelaVisualizandoGrupo> {

  @override
  Widget build(BuildContext context) {
    return Consumer<GrupoProvider>(builder: (context, valorArmazenado, child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
            Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 100.0),
                child: Row(
                  children: [
                    IconButton (
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0XFF1034B4),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                    ),
                    const SizedBox(width: 15.0,),
                    const Text(
                      "Visualizando grupo",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                      ),
                    ),
                    
                  ],
                ),
              ),
              const Text(
                "Integrantes",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF1034B4), 
                ),
              ),
              ListBody(
                children: [
                  for (String uid in widget.grupo.integrantes)
                    CardIntegrante(uid: uid),
                ],
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 105.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Firestore.entrarNoGrupo(widget.grupoId);
                      valorArmazenado.atualizaEstaEmGrupo(integrante: true, administrador: false);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Menu()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 20.0),
                      backgroundColor: const Color(0xFF040268),
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Lato',
                        fontSize: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Entrar no grupo'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}