void main(){
  //print("ilk dersimiz-Dart SDK aktif olmalı");
  //jdeki gibi let x='Ahemt' yaparrsak hata alırız
//A.ık belirtilen veri tipleri
/*
int seansSuresiDakika=45;
double seansUcretiTL=200;
String uzmanadi="Ahmet Aga";
bool aktifmi=true;

//2.String interpolation
//jsdeki``${}` yerine sadece $degisken islem var $(değisken2) kullanılır
print("Uzman Adı:$uzmanadi |Süre: $seansSuresiDakika|Ücret $seansUcretiTL");
print("KDV dahil (%20) ${seansUcretiTL*1.20}");

//3. var ile tip çıkarması
var tedaviAdi="Kahve ile peeling";

//4. dynamic veri tipinin bağımsız kullanabilirsiniz ancak flutterda önerilmez
dynamic serbestKutu="lazerEpilasyon";
serbestKutu=100;//izin verilir ama veri tipi güvenliğini yok eder

//const:derleme anında değeri belii olan veriler bellekte tek bir yerde saklanır
const String Klinik_Adi="SoftITo güzellik merkezi";
const double Kdv_Orani=0.2;
//const DateTime suankiZaman=DateTime.now();//Hata derleme anında

final DateTime randevuZamani=DateTime.now();
final String takipKodu="SOFT-"+ randevuZamani.microsecondsSinceEpoch.toString();

print("Klinik adi: $Klinik_Adi");
print("OLUŞTURULMA TARİHİ $randevuZamani |kod $takipKodu");

//dartta değişken varrsayılan olarak null olamaz onun yerine null safety operatörleri kullanılır (?,???,!!!)

String zorunluDanisanAdi="Ahmet Aga";
String? danisanAlerjiNotu;
print("alerji notu: $danisanAlerjiNotu");

//ifNull operatörü-null ise varsayılan değer atama
String goruntulecekNot=danisanAlerjiNotu ?? "Bilinen bir alerjisi yok";
print("Rapor: $goruntulecekNot");
print("alerji metin uzunluğu:${danisanAlerjiNotu?.lenght}");
*/

//Klasik sıralı fonksiyon
double topla(double a,double b)=>a+b;
//modern dart ve flutter standartları
void seansKaydiOlustur({
  required String danisan,
  required String tedavi,
  required double birimFiyat,
  int seansSayisi=1,//defaultdeğer
  double indirimOrani=0.0,//default değer
  String? uzmanHekim,//null olabilir

}){
  final double brutTutar=birimFiyat+seansSayisi;
  final double indirimTutar=brutTutar*(indirimOrani/100);
  final double netTutar=brutTutar-indirimTutar;


}
void main(){
  seansKaydiOlustur(danisan: "Ahmet Aga", tedavi: "Cilt", birimFiyat: 4500,
  seansSayisi: 3,indirimOrani: 15,uzmanHekim: "Akif Aga");
}


}





