import 'package:flutter_demo_2/models/kategori.dart';

abstract class IUrunServisi{
  Future<List<UrunModel>> urunleriGetir();
}