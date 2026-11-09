import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_demo_2/services/IUrunServisi.dart';
import 'package:flutter_demo_2/models/kategori.dart';

class CanliApiUrunServisi implements IUrunServisi {
  static const String _baseUrl = "https://fakestoreapi.com/products";

  @override
  Future<List<UrunModel>> urunleriGetir() async {
    try {
      final yanit = await http.get(Uri.parse(_baseUrl)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Ağ zaman aşımına uğradı');
        },
      );
      if (yanit.statusCode == 200) {
        final List<dynamic> hamListe = jsonDecode(yanit.body) as List<dynamic>;
        return hamListe
            .map((eleman) => UrunModel.fromJson(eleman as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Sunucu Hatası: ${yanit.statusCode}');
      }
    } catch (e) {
      debugPrint('Ağ hatası: $e');
      rethrow;
    }
  }
}
