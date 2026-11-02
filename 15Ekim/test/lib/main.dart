import 'package:flutter/material.dart';//material kütüphanesi şart tabi

// ---- Ekran import'ları (dosya adlarınla birebir uyumlu)
import 'screen/01_layout_screen.dart';//layout ekranı
import 'screen/02_market_list_screen.dart';//piyasa ekranı
import 'screen/03_transfer_form_screen.dart';//transfer ekranı

void main() {//uygulama buradan başlar
  runApp(const DtmMasterApp());//ana widget'ı çalıştır
}

class DtmMasterApp extends StatelessWidget {//ana uygulama sınıfı, state yok sabit
  const DtmMasterApp({super.key});//key al

  @override
  Widget build(BuildContext context) {
    return MaterialApp(//materyal uygulama kabı
      debugShowCheckedModeBanner: false,//sağ üstteki debug yazısını kapat
      title: "DTM Flutter Sınıfı",//uygulama adı
      theme: ThemeData(//tema ayarları
        useMaterial3: true,//yeni materyal tasarım kullan
        colorScheme: ColorScheme.fromSeed(//renk paleti tohumdan üretilir
          seedColor: const Color(0xFF6366F1),//renk değişr
          brightness: Brightness.light,//açık tema
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),//renk değişr
      ),
      home: const HomeShell(),//açılış ekranı
    );
  }
}

// ============================================================
// HOME SHELL — Alt navigasyon ile 3 ekranı toplar
// ============================================================
class HomeShell extends StatefulWidget {//seçili sekme değişecek o yüzden stateful
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();//state üret
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;//şu an hangi sekmede olduğumuz, 0'dan başlar

  // ---- Sadece 3 sekme: Layout, Piyasalar, Transfer
  static const List<_TabInfo> _tabs = [
    _TabInfo(
      label: 'Layout',
      icon: Icons.dashboard_outlined,//seçili değilken ikon
      selectedIcon: Icons.dashboard,//seçiliyken ikon
    ),
    _TabInfo(
      label: 'Piyasalar',
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view,
    ),
    _TabInfo(
      label: 'Transfer',
      icon: Icons.swap_horiz_outlined,
      selectedIcon: Icons.swap_horiz,
    ),
  ];

  // ---- Sekmenin gövdesi (her biri Scaffold ile sarılı)
  Widget _buildBody() {//index'e göre hangi ekranı göstereceğiz
    switch (_currentIndex) {
      case 0:
        // LayoutStylingScreen kendi Scaffold'una sahip değil → sarmalıyoruz
        return _ScaffoldedScreen(
          title: 'DTM Canlı Arayüz',
          body: const LayoutStylingScreen(),
        );
      case 1:
        // MarketsGridListScreen zaten kendi Scaffold'unu döndürüyor
        return const MarketsGridListScreen();
      case 2:
        // TransferFormScreen da kendi Scaffold'una sahip
        return const TransferFormScreen();
      default:
        return const SizedBox.shrink();//boş kutu, hiç bişe gösterme
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(//hepsi bellekte durur, hızlı geçiş için
        index: _currentIndex,//hangisi görünsün
        children: [
          _ScaffoldedScreen(
            title: 'DTM Canlı Arayüz',
            body: const LayoutStylingScreen(),//layout ekranı
          ),
          const MarketsGridListScreen(),//piyasa ekranı
          const TransferFormScreen(),//transfer ekranı
        ],
      ),
      bottomNavigationBar: NavigationBar(//alttaki navigasyon çubuğu
        selectedIndex: _currentIndex,//hangi sekme seçili
        onDestinationSelected: (index) {//tıklanınca çalışır
          setState(() => _currentIndex = index);//seçili sekmeyi güncelle
        },
        backgroundColor: Colors.white,//renk değişr
        indicatorColor: const Color(0xFFEEF2FF),//renk değişr
        destinations: _tabs.map((tab) {//her sekme için widget üret
          return NavigationDestination(
            icon: Icon(tab.icon, color: const Color(0xFF64748B)),//renk değişr
            selectedIcon: Icon(tab.selectedIcon, color: const Color(0xFF6366F1)),//renk değişr
            label: tab.label,//sekme yazısı
          );
        }).toList(),
      ),
    );
  }
}

// ============================================================
// YARDIMCI: Scaffold ile sarmalayıcı (LayoutStylingScreen için)
// ============================================================
class _ScaffoldedScreen extends StatelessWidget {//sarmalayıcı widget
  final String title;//başlık
  final Widget body;//içerik

  const _ScaffoldedScreen({required this.title, required this.body});//ikisi de zorunlu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),//renk değişr
      appBar: AppBar(//üst bar
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,//ortala
        backgroundColor: Colors.white,//renk değişr
        elevation: 0,//gölge yok
        actions: [//sağdaki ikonlar
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),//bildirim ikonu
            onPressed: () {//tıklayınca
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Yeni bildiriminiz yok 🎉'),//mesaj
                  backgroundColor: const Color(0xFF6366F1),//renk değişr
                  behavior: SnackBarBehavior.floating,//yüzen bildirim
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),//köşe yuvarlak
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: body,//içeriği koy
    );
  }
}

// ============================================================
// YARDIMCI: Sekme meta bilgisi
// ============================================================
class _TabInfo {//sekme bilgisini tutan küçük sınıf
  final String label;//yazı
  final IconData icon;//normal ikon
  final IconData selectedIcon;//seçili ikon

  const _TabInfo({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}