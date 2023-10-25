// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class TelaCriandoGrupo extends StatefulWidget {
//   const TelaCriandoGrupo({super.key, required this.enderecoDestino, required this.coordenadasDestino});

//   final LatLng coordenadasDestino;
//   final String enderecoDestino;

//   @override
//   State<TelaCriandoGrupo> createState() => _TelaCriandoGrupoState();
// }

// class _TelaCriandoGrupoState extends State<TelaCriandoGrupo> {
//   final TextEditingController  = TextEditingController();


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 100.0),
//               child: Row(
//                 children: [
//                   IconButton (
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       color: Color(0XFF1034B4),
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop(); 
//                     },
//                   ),
//                   const SizedBox(width: 15.0,),
//                   const Text(
//                     "Criando grupo",
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 18,
//                     ),
//                   ),
                  
//                 ],
//               ),
//             ),
//             SizedBox( 
//               width: MediaQuery.of(context).size.width,
//               height: 200.0,
//               child: FlutterMap(
//                 options: MapOptions (
//                   center: widget.coordenadasDestino,
//                   zoom: 17,
//                   maxZoom: 17,
//                   interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     userAgentPackageName: 'com.example.app',
//                   ),
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                         point: widget.coordenadasDestino, 
//                         builder: (context) => const Icon(
//                           Icons.location_pin,
//                           color: Colors.red,
//                           size: 30,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ]
//               ),
//             ),
//             const SizedBox(height: 20.0,),
//             Text("Criando grupo com destino a ${widget.enderecoDestino}"),
//             const SizedBox(height: 20.0,),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
//               child: Form(
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }