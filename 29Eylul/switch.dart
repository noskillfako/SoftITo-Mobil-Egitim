enum OlaySeviyesi { info, warning, error, critical }

String alarmKanaliniBelirle(OlaySeviyesi seviye, int tekrarSayisi) {
  return switch (seviye) {
    OlaySeviyesi.info => "dev-logs",
    OlaySeviyesi.warning => "dev-warning",
    OlaySeviyesi.error when tekrarSayisi >= 5 =>
      "Sms veya Email (mükerrer hata)",
    OlaySeviyesi.error => "Email:dev@site.com",
    OlaySeviyesi.critical =>
      "ACİL DURUM: Kriz odası otomatik node kapanışı",
  };
}

String httpKoduYorumla(int kod) {
  return switch (kod) {
    >= 200 && < 300 => "Başarılı",
    >= 400 && < 500 => "İstemci hatası",
    >= 500 && < 600 => "Sunucu hatası",
    _ => "Bilinmeyen HTTP durumu",
  };
}

void main() {
  print("Switch Expressions");
  print("Warning Kanalı: ${alarmKanaliniBelirle(OlaySeviyesi.warning, 1)}");
  print("Tekil Error Kanalı: ${alarmKanaliniBelirle(OlaySeviyesi.error, 1)}");
  print("Warnin Kanalı :${alarmKanaliniBelirle(OlaySeviyesi.warning, 1)}");
  print("Warnin Kanalı :${alarmKanaliniBelirle(OlaySeviyesi.warning, 1)}");

  print("HTTP 204 : ${httpKoduYorumla(204)}");
  print("HTTP 404 : ${httpKoduYorumla(404)}");
  print("HTTP 502 : ${httpKoduYorumla(502)}");  
}