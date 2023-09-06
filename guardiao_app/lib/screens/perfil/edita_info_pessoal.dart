import 'package:flutter/material.dart';

class TelaInformacoesPessoais extends StatelessWidget {
  const TelaInformacoesPessoais({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 844,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 64,
            top: 65,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(-3.14),
              child: Container(
                width: 32,
                height: 32,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(children: []),
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 178,
            child: Container(
              width: 309,
              height: 278,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 211,
            child: Text(
              'Maria Luiza Pereira',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(children: [
            Text(
              'Informações Pessoais',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
          Positioned(
            left: 37,
            top: 97,
            child: SizedBox(
              width: 326,
              child: Text(
                'Essas são as suas informações pessoais, elas não ficam visíveis no seu pergil.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 277,
            child: Text(
              '19998174271',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 337,
            child: Text(
              '*****',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 396,
            child: Text(
              'cc21347@g.unicamp.br',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 294,
            top: 207,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/30x30"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 294,
            top: 273,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/30x30"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 294,
            top: 329,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/30x30"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 294,
            top: 392,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/30x30"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 39,
            top: 253,
            child: Container(
              width: 310,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 317,
            child: Container(
              width: 310,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 379,
            child: Container(
              width: 310,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 771,
            child: Container(
              width: 390,
              height: 73,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 390,
                      height: 73,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF040268),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        /*
                      border: Border.only(
                        left: BorderSide(),
                        top: BorderSide(),
                        right: BorderSide(),
                        bottom: BorderSide(width: 0.15),
                      ),
                      */
                      ),
                    ),
                  ),
                  Positioned(
                    left: 46,
                    top: 13,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 30,
                          child: Text(
                            'Início',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 6,
                          top: 0,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/22x22"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 119,
                    top: 14,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 29,
                          child: Text(
                            'Denúncias',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 22,
                          top: 0,
                          child: Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/23x23"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 224,
                    top: 16,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 27,
                          child: Text(
                            'Alarme',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 14,
                          top: 0,
                          child: Container(
                            width: 19,
                            height: 19,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/19x19"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 310,
                    top: 15,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 28,
                          child: Text(
                            'Perfil',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 6,
                          top: 0,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/22x22"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Maria Luiza Pereira',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Informações Pessoais',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Essas são as suas informações pessoais, elas não ficam visíveis no seu perfil.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '19998174271',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '*****',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'cc21232@g.unicamp.br',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Início',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Denúncias',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Alarme',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.20,
                    ),
                  ),
                  Text('Perfil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.20,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}