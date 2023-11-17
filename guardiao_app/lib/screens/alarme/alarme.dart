import 'package:flutter/material.dart';
import 'package:guardiao_app/db/firestore.dart';
import 'package:guardiao_app/models/contato.dart';
import 'package:guardiao_app/models/usuario.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils.dart';

class TelaAlarme extends StatefulWidget {
  const TelaAlarme({super.key});

  @override
  State<TelaAlarme> createState() => _TelaAlarmeState();
}

class _TelaAlarmeState extends State<TelaAlarme> {

  bool botaoAcionado = false;
  
  enviarMensagens() async {
    Usuario? usuario = await Firestore.getUsuarioAtual();
    LatLng coordenadas = await getLocalizacaoAtual();

    if (usuario != null)
    {
      String uid = usuario.uid;
      List<String> numerosDeEmergencia = [];
      
      List<Contato> contatos = await Firestore.getContatosDeEmergencia(uid);
      if (contatos.isNotEmpty)
      {
        for (var contato in contatos) 
        {
          if (contato.numero != "")
          {
            numerosDeEmergencia.add(contato.numero);
          }
        }

        if (numerosDeEmergencia.isNotEmpty) 
        {
          String msg = "ALERTA DE EMERGÊNCIA! \n${usuario.nome} está em perigo e acionou o botão de pânico nas coordenadas [Latitude: ${coordenadas.latitude}, Longitude: ${coordenadas.longitude}]. \nEssa mensagem foi enviada através do botão de pânico do aplicativo guardião COTUCA.";
          String stringNumeros = numerosDeEmergencia.join(';'); // separando os numeros com ;
          String url = 'sms:$stringNumeros?body=$msg';
          Uri smsUrl = Uri.parse(url);
          
          if (await canLaunchUrl(smsUrl)) {
            await launchUrl(smsUrl);
            setState(() {
              botaoAcionado = true;
            });
          } else {
            if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Não foi possível enviar a mensagem aos contatos de emergência!')));
          }
        }
        else 
        {
           if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nenhum contato de emergência foi cadastrado!')));
        }
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDC3B3B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (botaoAcionado == false)
            const Text(
              "Você está em perigo?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'Lato',
              ),
            ) else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Confirme o envio da mensagem para notificar seus contatos de emergência!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'Lato',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (botaoAcionado == false)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Image.asset(
                    'assets/imagens/alarme.png',
                    fit: BoxFit.fill,
                    width: 223.0,
                    height: 235.0,
                  ),
              ),
            ) else
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Image.asset(
                    'assets/imagens/alarme_acionado.png',
                    fit: BoxFit.fill,
                    width: 223.0,
                    height: 235.0,
                  ),
              ),
            ),
            if (botaoAcionado == false)
            ElevatedButton (
              onPressed: () {
                enviarMensagens();
                setState(() {
                  botaoAcionado = true;
                });
              }, 
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(292.0, 78.0),
                backgroundColor: const Color.fromARGB(219, 193, 45, 45),
                textStyle: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Lato',
                  fontSize: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text (
                "ACIONAR ALARME",
              )
            ) else
            ElevatedButton (
              onPressed: () {
                enviarMensagens();
              }, 
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(292.0, 78.0),
                backgroundColor: const Color.fromARGB(219, 193, 45, 45),
                textStyle: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Lato',
                  fontSize: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text (
                "ALARME ACIONADO",
                style: TextStyle(
                  color: Color(0xFFF45E5E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}