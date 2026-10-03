class AltinSistemi {
  final String karakterAd;
  int _altinMiktar = 0;

  AltinSistemi({required this.karakterAd});

 
  double get altinMiktar => _altinMiktar.toDouble();

  
  void altinEkle(int miktar) {
    if (miktar < 0) {
      print("Sahte Altın Eklenemez");
      return;
    }
    _altinMiktar += miktar;
    print("$miktar altın kasaya eklendi. Toplam: $_altinMiktar");
  }

  void kasaYazdir() {
    print("[$karakterAd] Kasada $_altinMiktar altin var.");
  }
}
void main(){
  final kasa = AltinSistemi(karakterAd: "Ares");

  kasa.kasaYazdir();   
  kasa.altinEkle(100);      
  kasa.altinEkle(250);  
  kasa.altinEkle(-50);      
  kasa.kasaYazdir();        

  print("Getter ile okuma: ${kasa.altinMiktar}");
}