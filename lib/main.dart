import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'kayitekrani.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //Firebase ile iletişimi sağlamak için gerekli kod
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(scaffoldBackgroundColor: Colors.white ),
    debugShowCheckedModeBanner: false,
    home: KayitEkrani(),

  ));
}


