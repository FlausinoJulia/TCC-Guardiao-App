import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'guardiao_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(const GuardiaoApp());
}
