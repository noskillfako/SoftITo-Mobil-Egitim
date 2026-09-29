//1.Enumları (derleme Zamanı güvenliği)
//HizmetKategorisi: Klinikte sunulan hizmet türlerini tutar.
enum HizmetKategorisi { ciltYenileme, medikalEstetik, lazerEpilasyon, Lipo }

//SeansDurumu: Bir seansın (randevunun) hangi aşamada olduğunu belirtir.
enum SeansDurumu { bekliyor, odadaIslemde, tamamlandi, iptalEdildi }

//OdemeYontemi: Ödeme şekillerini tutar.
enum OdemeYontemi { krediKarti, havaleEft, nakit, klinikPaketKredisi }

//Danışan (müşteri) Modeli
//Danisan sınıfı: Bir müşteriyi/danışanı temsil eder.
class Danisan {
  //id: Danışanın benzersiz kimliği (değişmez).
  final String id;
  //adSoyad: Danışanın adı ve soyadı.
  final String adSoyad;
  //telefon: İletişim numarası.
  final String telefon;
  //vipUyeMi: VIP üye olup olmadığı
  final bool vipUyeMi;
  //alerjiler: Alerji listesi;
  final List<String> alerjiler; // boş olabilir ama null olamaz
  final String? ozelCiltNotu; // Opsiyonel Null olabilir

//Constructor: Nesne oluştururken kullanılır.
  const Danisan({
    //required: Bu alanlar mutlaka verilmeli (id, adSoyad, telefon)
    required this.id,
    required this.adSoyad,
    required this.telefon,
    //vipUyeMi verilmezse false kabul edilir.
    this.vipUyeMi = false,
    //alerjiler verilmezse boş liste [] olur.
    this.alerjiler = const [],
    //ozelCiltNotu verilmezse null olur.
    this.ozelCiltNotu,
  });

//Alerji listesi boş değilse true döner. Yani danışanın hassas cildi var mı bilgisini verir.
  bool get hassasCiltMi => alerjiler.isNotEmpty;

  //Bilgi özet kartı
  //bilgiOzeti getter'ı: Danışanın özet bilgisini tek satırda döndürür.
  String get bilgiOzeti {
    //Alerji listesi boşsa "Kayıtlı Alerji Yok", doluysa alerjileri virgülle birleştirip yazar.
    final String alerjiBilgisi = alerjiler.isEmpty
        ? "Kayıtlı Alerji Yok"
        : "Alerjiler: ${alerjiler.join(', ')}";
      //ozelCiltNotu null ise varsayılan metin, değilse kendi değeri kullanılır.
    final String notBilgisi = ozelCiltNotu ?? "Özel medikal not girilmemiş";
    //VIP ise "VİP", değilse "Standart" etiketi.
    final String vipRozeti = vipUyeMi ? "VİP" : "Standart";
    //Tüm bilgileri tek bir metin olarak döndürür ve sınıfı kapatır
    return "$vipRozeti $adSoyad ($telefon) | $alerjiBilgisi | Not: $notBilgisi";
  }
}

// Seans (randevu) Modeli

//SeansKaydi sınıfı: Bir randevu/seans kaydını temsil eder.
class SeansKaydi {
  //seansKodu: Seansın benzersiz kodu.
  final String seansKodu;
  //danisan: İlgili danışan nesnesi
  final Danisan danisan;
  //Hizmet kategorisi
  final HizmetKategorisi kategori;
  //yapılan işlem adı
  final String islemAdi;
  //birim fiyati
  final double birimFiyat;
  //seans sayısı
  final int seansSayisi;
  //yapılacak olan indirim oranı
  final double indirimOrani; // Örn 10.0
  //seansı yapan uzman null değer döndürebilir
  final String? sorumluUzman;
  //seansın durumu değiştirilebilir bu sebepten final değil
  SeansDurumu durum;
  //ödeme yöntemi null olabilir değiştirilebilir
  OdemeYontemi? odemeTipi;


  SeansKaydi({
    //Constructor: Zorunlu alanlar required ile işaretli
    required this.seansKodu,
    required this.danisan,
    required this.kategori,
    required this.islemAdi,
    required this.birimFiyat,
    this.seansSayisi = 1,
    this.indirimOrani = 0.0,
    //null olabilir
    this.sorumluUzman,
    //durum varsayılan SeansDurumu.bekliyor
    this.durum = SeansDurumu.bekliyor,
  //null olabilir
    this.odemeTipi,
  });

  //Brüt tutar: Birim fiyat × seans sayısı
  double get brutTutar => birimFiyat * seansSayisi;

  //İndirim tutarını hesaplar
  double get indirimTutari {
    double toplamOran = indirimOrani;
    //vip üye ise %10 indirim eklenir
    if (danisan.vipUyeMi) {
      toplamOran += 10.0;
    }
    //brututar değerini güncelleyip döndürür
    return brutTutar * (toplamOran / 100.0);
  }

  //Net tutar: Brüt tutar − indirim tutarı. Sınıfı kapatır.
  double get netTutar => brutTutar - indirimTutari;
}

// Yönetim Servisi

//KlinikYoneticisi: Klinik işlemlerini yöneten servis sınıfı.
class KlinikYoneticisi {
  //subeadi
  final String subeAdi;
  //tüm senasları tutar
  final List<SeansKaydi> _seanslar = [];
  //Id danışan eşleşmesi yapan map
  final Map<String, Danisan> _danisanRehberi = {};

//Sadece subeAdi ister.
  KlinikYoneticisi({required this.subeAdi});

  //Danışanı rehbere ID ile kaydeder ve ekrana bilgi yazar
  void danisanKaydet(Danisan danisan) {
    _danisanRehberi[danisan.id] = danisan;
    print(
      "Rehbere Eklendi: ${danisan.adSoyad} (${danisan.vipUyeMi ? "VİP" : "Standart"})",
    );
  }

  //Yeni seansı listeye ekler ve bilgi yazar
  void randevuOlustur(SeansKaydi seans) {
    _seanslar.add(seans);
    print(
      "Randevu Kaydedildi [${seans.seansKodu}]: ${seans.danisan.adSoyad}->${seans.islemAdi}",
    );
  }

//Yeni seansı listeye ekler ve bilgi yazar
  void seansiTamamla({required String seansKodu, required OdemeYontemi odeme}) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.tamamlandi;
        seans.odemeTipi = odeme;
        print(
          "Seans Tamamlandı: [${seans.seansKodu}]: ${seans.netTutar.toStringAsFixed(2)} tahsil edildi (${odeme.name})",
        );
        return;
      }
    }
    //seansı bulamayıp mesaj yazdırır return ile çıkar
    print("Hata [$seansKodu] kodlu seans bulunamadı");
    return;
  }

//Seans koduna göre seansı bulur, durumunu iptalEdildi yapar, iptal nedenini yazar ve return ile çıkar.
  void seansiIptalEt(String seansKodu, {String? iptalNedeni}) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.iptalEdildi;
        print(
          "Seans İptal Edildi [${seans.seansKodu}]: ${iptalNedeni ?? "Gerekçe Belirtilmedi"}",
        );
        return;
      }
    }
  }

  // Finansal Rapor Metotları(fonksiyonel dart)
  //Tamamlana seansları bulup net ciroyu hesaplar
  double get toplamTahsilEdilenCiro => _seanslar
      .where((s) => s.durum == SeansDurumu.tamamlandi)
      .fold(0.0, (toplam, s) => toplam + s.netTutar);

  //daha tamamlanmayan seansları bulup potansiyel ciroyu hesapalr
  double get beklenenPotansiyelCiro => _seanslar
      .where(
        (s) =>
            s.durum == SeansDurumu.bekliyor ||
            s.durum == SeansDurumu.odadaIslemde,
      )
      .fold(0.0, (toplam, s) => toplam + s.netTutar);

  // kategori bazlı seans sayıları

  Map<HizmetKategorisi, int> kategoriBazliSeansDagilimi() {
    //Kategori → seans sayısı map'i döner.
    final Map<HizmetKategorisi, int> dagilim = {};
    for (var kat in HizmetKategorisi.values) {
      //Her kategori için sayaç sıfırlanır
      dagilim[kat] = 0;
    }
    for (var s in _seanslar) {
      //Her seans için ilgili kategori sayısı 1 artırılır.
      dagilim[s.kategori] = (dagilim[s.kategori] ?? 0) + 1;
    }
    return dagilim;
  }

  //Tüm seanslardaki uzmanları alır, null olanları eler (whereType<String>), tekrarsız küme (Set) döner.
  Set<String> gorevliUzmanKadrosu() {
    return _seanslar.map((s) => s.sorumluUzman).whereType<String>().toSet();
  }

  //Uzmansız kalan seanslar
  //Sorumlu uzmanı null olan seansları liste olarak döner.
  List<SeansKaydi> uzmansizSeanslariGetir() {
    return _seanslar.where((s) => s.sorumluUzman == null).toList();
  }

//Başlık satırını yazdırır. padRight(n) metni sağa boşlukla tamamlar (hizalama).
  void gunSonuRaporuYazdir() {
    print("Günlük Seans ve İşlem Çizelgesi");
    print("---------------------------------------");
    print(
      "${'Kod'.padRight((10))} | "
      "${'Danışan'.padRight(16)} | "
      "${'İşlem'.padRight(20)} | "
      "${'Uzman'.padRight(18)} | "
      "${'Tutar'.padRight(10)} | "
      "${'Durum'} | ",
    );
    print("---------------------------------------");

    for (var s in _seanslar) {
      //seans için uzman=null ise önbetçi bekliyor yazar 
      final String uzman = s.sorumluUzman ?? " Nöbetçi Bekliyor";
      final String durumRozet = switch (s.durum) {
        //switch ifadesi ile durum enum'unu Türkçe metne çevirir
        SeansDurumu.tamamlandi => "Tamamlandı",
        SeansDurumu.odadaIslemde => "İşlemde",
        SeansDurumu.bekliyor => "Bekliyor",
        SeansDurumu.iptalEdildi => "İptal",
      };

//Her seansın bilgilerini hizalı şekilde yazdırır.
      print(
        "${s.seansKodu.padRight(10)} | "
        "${s.danisan.adSoyad.padRight(10)} | "
        "${s.islemAdi.padRight(10)} | "
        "${uzman.padRight(10)} | "
        "${s.netTutar.toStringAsFixed(2).padRight(10)} | "
        "$durumRozet",
      );
    }

//Finansal özet: gerçekleşen ciro, bekleyen alacak, toplam seans sayısı
    print("---------------------------------------");
    print("Finansal Özet:");
    print(
      " * Gerçekleşen (kasadaki net ciro) : ${toplamTahsilEdilenCiro.toStringAsFixed(2)}",
    );
    print(
      " * Bekleyen Potansiyen Alacak : ${beklenenPotansiyelCiro.toStringAsFixed(2)}",
    );
    print(" * Toplam Seans : ${_seanslar.length} Randevu");
    print("---------------------------------------");

    //Uzman kadrosunu listeler; boşsa Kayıtlı Uzman Bulunamadı verir
    print("Aktif Uzmanlar");
    final uzmanlar = gorevliUzmanKadrosu();
    if (uzmanlar.isEmpty) {
      print("Kayıtlı Uzman Bulunamadı");
    } else {
      print(" ${uzmanlar.join(', ')}");
    }
    //Uzmansiz seansları listeler
    final uzmansizlar = uzmansizSeanslariGetir();
    //Kaç tane seansa uzman atanmadığını yazar
    if (uzmansizlar.isNotEmpty) {
      print(
        "Dikkat: ${uzmansizlar.length} adet seansa henüz uzman atanmamıştır",
      );
      //uzman atanmamış seansın bilgilerini verir
      for (var u in uzmansizlar) {
        print("->[${u.seansKodu}] ${u.danisan.adSoyad} (${u.islemAdi})");
      }
    }
    print("---------------------------------------");
  }
}


void main() {
  //Program başlangıcı. Yönetici nesnesi oluşturulur
  print("Klinik yönetim sistemi başlatılıyor....");
  final yonetici = KlinikYoneticisi(subeAdi: "Softito Bağcılar Şubesi");

  //danışanları oluşturalım //1. danışan vip üye alerjileri var ve özel nota sahip
  final d1 = Danisan(
    id: "DAN-101",
    adSoyad: "Ahmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["Retinol","Aspirin"],
    ozelCiltNotu: "Cilt bariyeri hassas",
  );
  //2.Danışan vip değil alerjisi yok özel notu yok
  final d2 = Danisan(
    id: "DAN-102",
    adSoyad: "Ahmet Yılan",
    telefon: "0555 555 55 55",
    vipUyeMi: false,
    alerjiler: [],
  );
  //3.Danışan vip uye alerjileri var özel notu yok
  final d3 = Danisan(
    id: "DAN-103",
    adSoyad: "Mehmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["Retinol","Aspirin"],
  );
  //4.danışan vip uye alerjisi yok özel notu var 
  final d4 = Danisan(
    id: "DAN-104",
    adSoyad: "Ahmet Mehmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: [],
    ozelCiltNotu: "Cilt bariyeri hassas",
  );

//Tüm danışanlar rehbere kaydedilir
  yonetici.danisanKaydet(d1);
  yonetici.danisanKaydet(d2);
  yonetici.danisanKaydet(d3);
  yonetici.danisanKaydet(d4);

  print("Danışan güvenlik kontrolü");
  print(d1.bilgiOzeti);
  print(d2.bilgiOzeti);
  print("----------------------------------");

  // randevular oluşturuluyor
  //1.seans vip danışan uzman atanmış lipo 2 seans 5+10(vip)=%15 indirim
  final seans1 = SeansKaydi(
    seansKodu: "SNS-2026-1",
    danisan: d1,
    kategori: HizmetKategorisi.Lipo,
    islemAdi: "Lipo gerisini bilmiyorum",
    birimFiyat: 6500.0,
    seansSayisi: 2,
    indirimOrani: 5.0,
    sorumluUzman: "Sümeyye Arab",
  );
  //2.seans vip değil uzman atanmamış 5 seans cilt yenileme %15 indirim
  final seans2 = SeansKaydi(
    seansKodu: "SNS-2026-2",
    danisan: d2,
    kategori: HizmetKategorisi.ciltYenileme,
    islemAdi: "Siverex ile yüz temizleme",
    birimFiyat: 2500.0,
    seansSayisi: 5,
    indirimOrani: 15.0,
    sorumluUzman: null,
  );
  //3.seans vip değil lazer epilasyon 15 seans uzman atanmış 
  final seans3 = SeansKaydi(
    seansKodu: "SNS-2026-3",
    danisan: d3,
    kategori: HizmetKategorisi.lazerEpilasyon,
    islemAdi: "Tüm Vücut",
    birimFiyat: 25000.0,
    seansSayisi: 15,
    indirimOrani: 0.0,
    sorumluUzman: "Tuba Aydın",
  );
  //4.seans vip değil uzman atanmış 3 seans
  final seans4 = SeansKaydi(
    seansKodu: "SNS-2026-4",
    danisan: d4,
    kategori: HizmetKategorisi.medikalEstetik,
    islemAdi: "Burun Estetiği",
    birimFiyat: 1500.0,
    seansSayisi: 3,
    sorumluUzman: "Alaaddin Odabaşı",
  );
  //Tüm seanslar sisteme kaydedilir
  yonetici.randevuOlustur(seans1);
  yonetici.randevuOlustur(seans2);
  yonetici.randevuOlustur(seans3);
  yonetici.randevuOlustur(seans4);
  print("Seanslar Gönderiliyor");

  //seans 1 başarıyla tamamlanıyor (kredi kartı ile ödeme);
  yonetici.seansiTamamla(
    seansKodu: "SNS-2026-1",
    odeme: OdemeYontemi.krediKarti,
  );
  //seans 2 başarıyla tamamlanıyor (nakit ödeme);
  yonetici.seansiTamamla(seansKodu: "SNS-2026-2", odeme: OdemeYontemi.nakit);
  //seans 4 iptal ediliyor
  yonetici.seansiIptalEt(
    "SNS-2026-4",
    iptalNedeni: "Danışanın şehir dışından tanıdığı geldiği için gelemedi",
  );

//Gün sonu raporu yazdırılır ve program biter.
  yonetici.gunSonuRaporuYazdir();
}