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
              onPressed: (){}, 
              child: Text("ACIONAR ALARME")
            ),
          ],
        ),
      ),
    );
  }
}