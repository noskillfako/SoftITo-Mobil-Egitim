import 'package:flutter/material.dart';
import 'market_list_screen.dart'; // Film listesi ekranı
import 'transfer_form_screen.dart'; // Film ekleme formu

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0; // Hangi sekmede olduğumuzu tutar

  // Sekmelerde gösterilecek ekranların listesi
  final List<Widget> _screens = [
    const MarketListScreen(), // 0. Index: Film Listesi
    const TransferFormScreen(), // 1. Index: Film Ekleme
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body kısmında seçili olan ekranı gösterir
      body: _screens[_selectedIndex],
      
      // Alt Menü (Navigation Bar)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: const Color(0xFF2C2C2C),
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            activeIcon: Icon(Icons.movie),
            label: 'Arşivim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            activeIcon: Icon(Icons.add_box),
            label: 'Film Ekle',
          ),
        ],
      ),
    );
  }
}