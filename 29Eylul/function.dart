typedef MetrikUyariKurali=bool Function(double deger);

void metrikDenetle({
  required String metrikAdi,
  required double mevcutDeger,
  required MetrikUyariKurali kural,
  required void Function(String mesaj) alertTetikleyici,
}) {
  if (kural(mevcutDeger)) {
    alertTetikleyici(
      "Uyari: $metrikAdi eşik değerini aşti. mevcut:$mevcutDeger",
    );
  } else {
    print("$metrikAdi normal sinirlar içinde ($mevcutDeger)");
  }
}

void main(){
  print("Metrik Uyarilar");
  final MetrikUyariKurali yuksekCpu=(deger)=>deger>=85.0;
  final MetrikUyariKurali yuksekRam=(deger)=>deger>=90.0;

  metrikDenetle(metrikAdi: "Cpu", mevcutDeger: 92.5, kural: yuksekCpu, alertTetikleyici:(msg)=>print("Bildirim Gönderildi => $msg"));
  metrikDenetle(metrikAdi: "Ram", mevcutDeger: 94.5, kural: yuksekRam, alertTetikleyici:(msg)=>print("Bildirim Gönderildi => $msg"));
}
