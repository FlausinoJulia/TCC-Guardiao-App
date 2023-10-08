import 'package:flutter/material.dart';

class TelaAlarme extends StatefulWidget {
  const TelaAlarme({super.key});

  @override
  State<TelaAlarme> createState() => _TelaAlarmeState();
}

class _TelaAlarmeState extends State<TelaAlarme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDC3B3B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Você está em perigo?"),
            Container(
              decoration: BoxDecoration(
                
              ),
            ),
            ElevatedButton(
              onPressed: (){}, 
              child: Text("ACIONAR ALARME")
            ),
          ],
        ),
      ),
    );
  }
}