import 'package:geolocator/geolocator.dart';

class LocalizacaoController {
  double latitude = 0.0;
  double longitude = 0.0;
  String erro = '';

  LocalizacaoController() {
    getPosicao();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();


      latitude = posicao.latitude;
      longitude = posicao.longitude;
    } catch (e) {
      erro = e.toString();
    }
  }

  static Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    
    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização.');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização.');
    }

    return await Geolocator.getCurrentPosition();
  }
}