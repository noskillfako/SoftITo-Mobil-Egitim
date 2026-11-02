/*
Future<void> fecthDashBoardaData() async{
  try{
    final result =await Future.wait([
      fecthUserProfile(),
      fecthAccountBalance(),
      fecthNotifications(),
    ],eagerError: true);
    print("Tüm veriler geldi $result");
  } catch (e) {
    print("İsteklerden Biri Basarisiz Oldu $e");
  }
}
*/

//Future:Tek bir veri çekileceği zaman kullanılır ya hata ya da değer dönüp bitirilir 
//Stream:Bir boru hattı şeklinde çalışır(pipe),zaman içinde 1-10-1000 veya sonsuz sayıda veri aktarımı yapılabilir
//(Borsa fiyatları çekerken GPS konumgüncelleme Firebase canlı dinleme)

//asenkron programlaam için bütün fonksiyon ve sınıfları dahil eder
import 'dart:async';

void main(){
  //Controller oluşturma
  final controller=StreamController<int>();
  //dinleyici bağlama
  final subscription=controller.stream.listen(
    (data)=>print("Veri geldi: $data"),
    onError: (error)=>print("Hata geldi: $error"),
    onDone: ()=>print("Yayın kapandı"),
  );
  //streame veri gönderme fonksiyonu
  controller.sink.add(10);
  controller.sink.add(20);
  controller.sink.add(30);

//controller streami brodcaste çevirme fonksiyonu
  final broadcastStream=controller.stream.asBroadcastStream();
  //UI Ekranı adında listener ekleme
  broadcastStream.listen((d)=>print("UI Ekranı: $d"));
  //Analitik Servis Ekranı adında listener ekleme
  broadcastStream.listen((d)=>print("Analitik Servisi Ekranı: $d"));

//controller'kapatma
  controller.close();



}
