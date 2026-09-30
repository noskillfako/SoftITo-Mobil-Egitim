class SunucuMetrigi{
  final String hostAdi;
  final String bolge;
  final double cpuYuzdesi;
  final double ramGb;
  final int aktifBaglantiSayisi;
  final bool kritikmi;

const SunucuMetrigi({
  required this.hostAdi,
  required this.bolge,
  required this.cpuYuzdesi,
  required this.ramGb,
  required this.aktifBaglantiSayisi,
  this.kritikmi=false

});

@override
String toString() =>
    "$hostAdi [$bolge] (CPU: %$cpuYuzdesi,Ram:${ramGb}GB,Conn: $aktifBaglantiSayisi)";

}

void main(){
  print("Cloud Temelleri");

  final List<SunucuMetrigi> sunucuKumesi = [
    SunucuMetrigi(
      hostAdi: "Server-EU-1",
      bolge: "eu-west",
      cpuYuzdesi: 45.2,
      ramGb: 16.0,
      aktifBaglantiSayisi: 1200,
      kritikmi: true,
    ),
  ];

  //where() ile filtreleme: cpu kullanımı %80 üzerinde olan sunucular
final asiriYukluSunucular = sunucuKumesi.where((s) => s.cpuYuzdesi >= 80.0).toList();
print("Aşırı Yüklü Sunucular (${asiriYukluSunucular.length})");
asiriYukluSunucular.forEach((s) => print("* $s"));

final List<String> alarmEtiketleri = sunucuKumesi
    .map(
      (s) =>
          "[Alert-Monitor] ${s.hostAdi.toLowerCase()} ->Aktif Trafik ${s.aktifBaglantiSayisi}",
    )
    .toList();
print("Alarm Çiktilari (ilk 3 tane)");
alarmEtiketleri.take(3).forEach((e) => print(" $e"));
}