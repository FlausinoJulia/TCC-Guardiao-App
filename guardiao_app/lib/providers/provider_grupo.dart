import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class GrupoProvider extends ChangeNotifier {
  bool ehAdministrador = false;
  bool ehIntegrante = false;
  List<LatLng> coordenadasDaRota = [];

  GrupoProvider({
    this.ehAdministrador = false,
    this.ehIntegrante = false
  });

  void atualizaEstaEmGrupo ({
    required bool integrante,
    required bool administrador,
  }) async {
    ehAdministrador = administrador;
    ehIntegrante = integrante;
    notifyListeners();
  }

  void atualizaCoordenadas({
    required List<LatLng> coordenadas
  }) async {
    coordenadasDaRota = coordenadas;
     }
}