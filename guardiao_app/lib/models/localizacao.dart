import 'package:cloud_firestore/cloud_firestore.dart';

class Localizacao {
  double latitude;
  double longitude;

  Localizacao({required this.latitude, required this.longitude});

  factory Localizacao.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Localizacao(
      latitude: data?['latitude'],
      longitude: data?['longitude'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}