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
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: const Color(0xFFE9E9E9),
        constraints: const BoxConstraints(
          maxWidth: 200.0,
          minHeight: 50.0,
          maxHeight: 182.0,
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              color: const Color(0xFF6C6C6C),
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