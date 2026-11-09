import 'package:flutter/material.dart';
import 'package:flutter_demo_2/models/kategori.dart';
import 'package:flutter_demo_2/services/IUrunServisi.dart';
import 'package:flutter_demo_2/services/api_servis.dart';

class UrunListesi extends StatefulWidget{
  const UrunListesi({super.key});

  @override
  State<UrunListesi> createState()=>_UrunListesiEkraniState();
}

class _UrunListesiEkraniState extends State<UrunListesi>{
  late IUrunServisi _urunServisi;
  List<UrunModel> _urunler=[];
  bool _yukleniyor=false;
  String? _hata;

  @override
  void initState(){
    super.initState();
    _urunServisi=CanliApiUrunServisi();
    _urunleriGetir();
  }

  Future<void> _urunleriGetir()async{
    setState((){
      _yukleniyor=true;
      _hata=null;
    });
    try{
      _urunler=await _urunServisi.urunleriGetir();
    }catch(e){
      _hata='Urunler yuklenirken hata olustu: $e';
    }finally{
      if(mounted){
        setState((){
          _yukleniyor=false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Listesi'),
      ),
      body: _govdeyiOlustur(),
    );
  }

  Widget _govdeyiOlustur(){
    if(_yukleniyor){
      return const Center(child: CircularProgressIndicator());
    }
    if(_hata != null){
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _hata!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _urunleriGetir,
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      );
    }
    if(_urunler.isEmpty){
      return const Center(child: Text('Gösterilecek ürün bulunamadı.'));
    }
    return ListView.builder(
      itemCount: _urunler.length,
      itemBuilder: (context, index){
        final urun = _urunler[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: Image.network(
              urun.resimUrl,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 50),
            ),
            title: Text(
              urun.baslik,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(urun.kategori),
            trailing: Text(
              '\$${urun.fiyat.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
