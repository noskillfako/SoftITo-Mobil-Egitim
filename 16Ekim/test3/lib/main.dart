import 'package:flutter/material.dart';
import 'screen/layout_screen.dart'; // Layout ekranımızı çağırıyoruz

void main() {
  runApp(const MovieArchiveApp());
}

class MovieArchiveApp extends StatelessWidget {
  const MovieArchiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Arşivim',
      debugShowCheckedModeBanner: false, // Sağ üstteki 'debug' yazısını kaldırır
      theme: ThemeData(
        // Karanlık bir tema film arşivine çok yakışır :)
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
      ),
      home: const LayoutScreen(), // İlk açılacak ekran
    );
  }
}