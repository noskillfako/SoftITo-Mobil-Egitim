import 'package:flutter/material.dart';

// ---- Ekran import'ları (dosya adlarınla birebir uyumlu)
import 'screen/01_layout_screen.dart';
import 'screen/02_market_list_screen.dart';
import 'screen/03_transfer_form_screen.dart';

void main() {
  runApp(const DtmMasterApp());
}

class DtmMasterApp extends StatelessWidget {
  const DtmMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DTM Flutter Sınıfı",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const HomeShell(),
    );
  }
}

// ============================================================
// HOME SHELL — Alt navigasyon ile 3 ekranı toplar
// ============================================================
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  // ---- Sadece 3 sekme: Layout, Piyasalar, Transfer
  static const List<_TabInfo> _tabs = [
    _TabInfo(
      label: 'Layout',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
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
  Widget _buildBody() {
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
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _ScaffoldedScreen(
            title: 'DTM Canlı Arayüz',
            body: const LayoutStylingScreen(),
          ),
          const MarketsGridListScreen(),
          const TransferFormScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFEEF2FF),
        destinations: _tabs.map((tab) {
          return NavigationDestination(
            icon: Icon(tab.icon, color: const Color(0xFF64748B)),
            selectedIcon: Icon(tab.selectedIcon, color: const Color(0xFF6366F1)),
            label: tab.label,
          );
        }).toList(),
      ),
    );
  }
}

// ============================================================
// YARDIMCI: Scaffold ile sarmalayıcı (LayoutStylingScreen için)
// ============================================================
class _ScaffoldedScreen extends StatelessWidget {
  final String title;
  final Widget body;

  const _ScaffoldedScreen({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Yeni bildiriminiz yok 🎉'),
                  backgroundColor: const Color(0xFF6366F1),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: body,
    );
  }
}

// ============================================================
// YARDIMCI: Sekme meta bilgisi
// ============================================================
class _TabInfo {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const _TabInfo({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}