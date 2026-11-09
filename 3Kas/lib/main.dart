import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veritabani/firebase_options.dart';
import 'package:veritabani/firestore_yonetim_ekrani.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();//yerel kanlları firebaseden önce kaldırmak için
  await Firebase.initializeApp(
    options:
    DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SoftitoFirestoreUygulamasi());
}

class SoftitoFirestoreUygulamasi extends StatelessWidget{
  const SoftitoFirestoreUygulamasi({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cloud FireStore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const FirestoreYonetimEkrani(),
    );
  }
}