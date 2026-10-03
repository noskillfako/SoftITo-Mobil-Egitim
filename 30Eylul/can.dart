class CanSistemi {
  final String karakterAd;
  double _canPuani = 100.0; // başındaki alt çizgi bu değişkeni gizli olarak kodlar

  CanSistemi({required this.karakterAd});

  // getter ile can puanını dışarıya okutma
  double get canPuani {
    return _canPuani;
  }

  // seter ile can puanı değişirken oyun kurallarını denetleyelim
  set canPuani(double yeniCan) {
    if (yeniCan <= 0.0) {
      _canPuani = 0.0;
      print("$karakterAd cani 0'a düştü ve öldü");
    } else if (yeniCan > 100.0) {
      _canPuani = 100.0;
      print("Can tamamen dolu");
    } else {
      _canPuani = yeniCan;
    }
  }

  bool get hayattaMi {
    return _canPuani > 0.0;
  }
}
void main(){
  print("Can Bari Güvenlik Sistemi");
  final savaciCani=CanSistemi(karakterAd: "Zegabon");
  print("Baslangıç Can      :HP ${savaciCani.canPuani}");
  print("35 puan Hasar alındı");
  savaciCani.canPuani=65.0;
  print("Kalan Can      :HP ${savaciCani.canPuani}");
  print("200 can veren iksir içildi ");
  savaciCani.canPuani=265.00;
  print("Sabitlenen Can      :HP ${savaciCani.canPuani}");
  print("Ölümcül Darbe Aldı");
  savaciCani.canPuani=-50.0;
  print("Nihai Can      :HP ${savaciCani.canPuani}");
  print(
    "Savaşçı Hayatta Mi?  : ${savaciCani.hayattaMi ? 'Evet':'Hayir'}",
  );
}