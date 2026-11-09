import 'package:flutter/material.dart';
import '../controllers/sepet_kontrolu.dart';

class ProfilEkrani extends StatelessWidget {
  const ProfilEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: TextButton(
          onPressed: () => SepetKontrolu.ornek.sepetSifirla(),
          child: const Text('Sepeti Temizle(0 Yap)'),
        ),
      ),
    );
  }
}
