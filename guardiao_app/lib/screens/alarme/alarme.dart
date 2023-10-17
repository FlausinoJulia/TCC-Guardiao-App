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
          } else {
            print('n deu nao'); // arrumar isso aqui
          }
        }
      }
    }
    

    
    //if (usuario!.contatosDeEmergencia!.any((element) => ))

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDC3B3B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Você está em perigo?"),
            Center(
              child: Container(
                height: 400,
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 77, 70, 70),
                          borderRadius: BorderRadius.all(
                            Radius.circular(300),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: const BorderRadius.all(Radius.circular(300))
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: 25,
                      bottom: 75,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 184, 40, 40),
                          borderRadius: const BorderRadius.all(Radius.circular(300))
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: 25,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 227, 79, 79),
                          borderRadius: const BorderRadius.all(Radius.circular(300))
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                enviarMensagens();
              }, 
              child: const Text("ACIONAR ALARME")
            ),
          ],
        ),
      ),
    );
  }
}