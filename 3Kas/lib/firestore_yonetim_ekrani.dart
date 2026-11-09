import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veritabani/models/ogrenci_model.dart';


class FirestoreYonetimEkrani extends StatefulWidget{
  const FirestoreYonetimEkrani({super.key});
  @override
  State<FirestoreYonetimEkrani> createState()=>_FirestoreYonetimEkraniState();

}

class _FirestoreYonetimEkraniState extends State<FirestoreYonetimEkrani>{
  final FirestoreOgrenciServisi _servis=FirestoreOgrenciServisi();

  final TextEditingController _adsoyadKontrolcusu=TextEditingController();
  final TextEditingController _projeKontrolcusu=TextEditingController();
  final TextEditingController _notKontrolcusu=TextEditingController();

  @override
  void dispose(){

_adsoyadKontrolcusu.dispose();
_notKontrolcusu.dispose();
_projeKontrolcusu.dispose();
super.dispose();
}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar:AppBar(
      title:const Text("Canlı Firestore Ekrani"),
      backgroundColor:Colors.amber.shade600,
    ),
    body:Column(
      children:[
        Padding(
        padding: const EdgeInsets.all(12.0),
        child:Padding(
          padding: const EdgeInsets.all(12.0),
          child:Column(
            children:[
              TextField(
                controller: _adsoyadKontrolcusu,
                decoration: const InputDecoration(
                  labelText: "Öğrenci Adı Soyadı",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height:8),
              //proje bölümü ekle
              TextField(
                controller: _projeKontrolcusu,
                decoration: const InputDecoration(
                  labelText: "Proje Adı",
                  prefixIcon: Icon(Icons.work),
                ),

              ),
              const SizedBox(height: 8),
                TextField(
                  controller: _notKontrolcusu,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText:"Not (0-100)",
                    prefixIcon: Icon(Icons.grade),
                  ),
                ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                style:ElevatedButton.styleFrom(
                  backgroundColor:Colors.pink,
                  foregroundColor:Colors.brown,
                  minimumSize:const Size.fromHeight(44),
                ),
                onPressed: _yeniOgrenciKaydet,
                icon: const Icon(Icons.cloud_upload),
                label: const Text("Buluta Kaydet"),
              ),
            ],
          ),
        ),
        ),
        const Divider(thickness: 2),
        Expanded(
          child:StreamBuilder<QuerySnapshot>(
            stream:FirebaseFirestore.instance.collection('ogrenciler')
            .orderBy('notu',descending: true)
            .snapshots(),
            builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Center(child: Text("Bulut hatası:${snapshot.error}"));
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
              return const Center(child: Text("Henüz bulutta kayıtlı öğrenci yoktur"),
              );
            }
            final List<DocumentSnapshot> dokumanlar=snapshot.data!.docs;
            return ListView.builder(
              itemCount:dokumanlar.length,
              itemBuilder: (context,index){
                final doc=dokumanlar[index];
                final ogrenci=OgrenciModel.fromFireStore(doc);
                return Dismissible(
                  key: Key(ogrenci.id),
                  direction:DismissDirection.endToStart,
                  background:Container(
                    alignment:Alignment.centerRight,
                    padding:const EdgeInsets.only(right:20),
                    color:Colors.red,
                    child:const Icon(Icons.delete_forever,color:Colors.white),
                  ),
                  onDismissed: (direction){
                    _servis.ogrenciSilme(ogrenci.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content:Text('${ogrenci.adSoyad} buluttan silindi')),
                    );
                  },
                  child:ListTile(
                    leading: CircleAvatar(
                      backgroundColor:ogrenci.notu>=80 ? Colors.green :(ogrenci.notu>=50 ? Colors.orange:Colors.red),
                      child:Text(
                        '${ogrenci.notu}',
                        style:const TextStyle(color:Colors.white,fontWeight:FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      ogrenci.adSoyad,
                      style:const TextStyle(fontWeight:FontWeight.bold),
                    ),
                    subtitle:Text('Proje:${ogrenci.projeAdi}'),
                    trailing: IconButton(
                      onPressed: ()=>_notguncelleDialog(ogrenci),
                      icon: const Icon(
                        Icons.edit,
                        color:Colors.amberAccent,
                      ),
                      ),
                  ),
                );
                },
              );
              },
            ),
          ),
      ],
    ),
    );
  }
  void _yeniOgrenciKaydet(){
    final adSoyad = _adsoyadKontrolcusu.text.trim();
    final proje= _projeKontrolcusu.text.trim();
    final not=int.tryParse(_notKontrolcusu.text.trim()) ?? 0;

    if(adSoyad.isEmpty || proje.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen ad soyad ve proje adını giriniz')),
      );
      return ;
    }
    _servis.ogrenciEkle(adSoyad: adSoyad, projeAdi: proje, notu: not);
    _adsoyadKontrolcusu.clear();
    _projeKontrolcusu.clear();
    _notKontrolcusu.clear();
  }

  Future<void> _notguncelleDialog(OgrenciModel ogrenci) async {
  final controller = TextEditingController(text: ogrenci.notu.toString());

  await showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(ogrenci.adSoyad),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Yeni Not'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () async {
            final yeniNot = int.tryParse(controller.text.trim());
            if (yeniNot == null || yeniNot < 0 || yeniNot > 100) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Geçerli bir not girin (0-100)')),
              );
              return;
            }
            try {
              await _servis.ogrenciNotuGuncelle(ogrenci.id, yeniNot);
              if (dialogContext.mounted) Navigator.pop(dialogContext);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${ogrenci.adSoyad} güncellendi')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hata: $e')),
                );
              }
            }
          },
          child: const Text('Kaydet'),
        ),
      ],
    ),
  );

  controller.dispose();
}
}

/*Yapılacaklar
1 expanded içinde projeadı inputu açılacak
2 _notGuncelleDialog fonksiyonu yazılacak
3 sayfalar parse edilecek ve sistem çalışır hale getirilicek
4 yarı nrastgele bir kişi seçilip ekrandan anlatacak*/