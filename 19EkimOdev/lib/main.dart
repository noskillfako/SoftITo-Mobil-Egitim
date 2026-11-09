import 'package:flutter/material.dart';
import 'features/blood_donation/controllers/blood_donation_controller.dart';//kontrolcu
import 'features/blood_donation/view/add_donation_view.dart';//bagis ekleme ekrani
import 'features/blood_donation/view/chart_view.dart';//grafik ekrani

void main() {//uygulama baslangici
  runApp(const BloodDonationApp());//kok widget'i calistir
}

class BloodDonationApp extends StatefulWidget {//ana uygulama sinifi
  const BloodDonationApp({super.key});//key al

  @override
  State<BloodDonationApp> createState() => _BloodDonationAppState();//state olustur
}

class _BloodDonationAppState extends State<BloodDonationApp> {
  final BloodDonationController _controller = BloodDonationController();//controller olustur

  @override
  void dispose() {//kapaninca
    _controller.dispose();//controlelr temizle
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(//tema modunu dinle
      valueListenable: _controller.themeMode,//dinlenecek deger
      builder: (context, themeMode, _) {//degisince calisir
        return MaterialApp(//materyal uygulama
          title: 'Kan Bagis Grafigi',//uygulama adi
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,//tema modu
          theme: ThemeData(//acik tema
            useMaterial3: true,//materyal 3 kullan
            brightness: Brightness.light,//acik mod
            colorScheme: ColorScheme.fromSeed(//renk semasi
              seedColor: const Color(0xFFFF1744), // Vibrant Electric Crimson
              primary: const Color(0xFFFF1744),//renk degisir
              brightness: Brightness.light,//acik
            ),
            scaffoldBackgroundColor: const Color(0xFFF6F8FC),//renk degisir
            cardTheme: CardThemeData(//kart temasi
              color: Colors.white,//renk degisir
              elevation: 0,//golge yok
              shape: RoundedRectangleBorder(//kose sekli
                borderRadius: BorderRadius.circular(18),//kose yuvarlak
              ),
            ),
            appBarTheme: const AppBarTheme(//ust bar temasi
              centerTitle: true,//ortala
              elevation: 0,//golge yok
              scrolledUnderElevation: 0,//kaydirinca golge yok
            ),
          ),
          darkTheme: ThemeData(//karanlik tema
            useMaterial3: true,//materyal 3
            brightness: Brightness.dark,//karanlik mod
            colorScheme: ColorScheme.fromSeed(//renk semasi
              seedColor: const Color(0xFFFF2A6D), // Vibrant Neon Rose
              primary: const Color(0xFFFF2A6D),//renk degisir
              surface: const Color(0xFF161922),//renk degisir
              brightness: Brightness.dark,//karanlik
            ),
            scaffoldBackgroundColor: const Color(0xFF0F1117), // Deep Obsidian
            cardTheme: CardThemeData(//kart temasi
              color: const Color(0xFF161922),//renk degisir
              elevation: 0,//golge yok
              shape: RoundedRectangleBorder(//kose sekli
                borderRadius: BorderRadius.circular(18),//kose yuvarlak
              ),
            ),
            appBarTheme: const AppBarTheme(//ust bar temasi
              centerTitle: true,//ortala
              elevation: 0,//golge yok
              scrolledUnderElevation: 0,//kaydirinca golge yok
              backgroundColor: Color(0xFF161922),//renk degisir
            ),
            navigationBarTheme: const NavigationBarThemeData(//alt bar temasi
              backgroundColor: Color(0xFF161922),//renk degisir
              indicatorColor: Color(0x33FF2A6D),//renk degisir
            ),
          ),
          home: HomeShell(controller: _controller),//acilis ekrani
        );
      },
    );
  }
}

class HomeShell extends StatefulWidget {//
  const HomeShell({super.key, required this.controller});//key ve controlle

  final BloodDonationController controller;//conttrroller

  @override
  State<HomeShell> createState() => _HomeShellState();//state olustur
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;//secili sekme

  @override
  Widget build(BuildContext context) {
    final pages = [//sekme sayfalari
      AddDonationView(controller: widget.controller),//bagis ekleme
      ChartView(controller: widget.controller),//grafik
    ];

    return Scaffold(//ana sayfa
      body: IndexedStack(index: _index, children: pages),//sekmeye gore sayfa
      bottomNavigationBar: NavigationBar(//alt navigasyon
        selectedIndex: _index,//secili sekme
        onDestinationSelected: (i) => setState(() => _index = i),//tiklayinca degistir
        destinations: const [//sekmeler
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),//normal ikon
            selectedIcon: Icon(Icons.add_circle),//secili ikon
            label: 'Bagis Ekle',//yazi
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),//normal ikon
            selectedIcon: Icon(Icons.bar_chart),//secili ikon
            label: 'Grafik',//yazi
          ),
        ],
      ),
    );
  }
}