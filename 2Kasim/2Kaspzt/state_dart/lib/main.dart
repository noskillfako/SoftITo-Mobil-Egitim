import 'package:flutter/material.dart';
import 'controllers/GoRouter.dart';

void main() {
  runApp(const Uygulama());
}

class Uygulama extends StatelessWidget {
  const Uygulama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: uygulamaRotalari,
    );
  }
}
