import 'package:flutter/material.dart';

class CardDenuncia extends StatefulWidget {
  const CardDenuncia({
    super.key,
    required this.nomeUsuario,
    required this.descricao,
  });

  final String nomeUsuario;
  final String descricao;

  @override
  State<CardDenuncia> createState() => _CardDenunciaState();
}

class _CardDenunciaState extends State<CardDenuncia> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
            ), // local para colocar a foto
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
                    child: Text(
                      widget.descricao,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}