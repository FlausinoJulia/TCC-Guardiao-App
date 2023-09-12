import 'package:flutter/material.dart';

class TelaDenuncias extends StatefulWidget {
  const TelaDenuncias({super.key});

  @override
  State<TelaDenuncias> createState() => _TelaDenunciasState();
}

class _TelaDenunciasState extends State<TelaDenuncias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            // ListView.builder(
            //   itemBuilder: ,
            // ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 105.0,
              child: ElevatedButton(
                
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF040268),
                  textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Lato',
                    fontSize: 18,
                  )

                ),
                child: const Text('Fazer uma denúncia'),
              ),
            )
          ],
        ),
      ),
    );
  }
}