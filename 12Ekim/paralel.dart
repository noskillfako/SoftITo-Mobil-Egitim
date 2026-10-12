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
  controller.sink.add(10);
  controller.sink.add(20);
  controller.sink.add(30);

  final broadcastStream=controller.stream.asBroadcastStream();
  broadcastStream.listen((d)=>print("UI Ekranı: $d"));
  broadcastStream.listen((d)=>print("Analitik Servisi Ekranı: $d"));

  controller.close();



}
