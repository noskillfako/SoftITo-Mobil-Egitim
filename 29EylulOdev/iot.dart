enum CihazTipi { sensor, gateway, edgeServer, router }

class IotCihaz {
  final String seriNo;
  final String cihazAdi;
  final CihazTipi cihazTipi;
  final double cpuYukYuzdesi;
  final int bellekMb;
  final Set<String> acikPortlar;
  final bool sslSertifikasiGecerliMi;
  IotCihaz({
    required this.seriNo,
    required this.cihazAdi,
    required this.cihazTipi,
    required this.cpuYukYuzdesi,
    required this.bellekMb,
    required this.acikPortlar,
    required this.sslSertifikasiGecerliMi,
  });
  bool get guvenlikAcigiVarMi =>
      !sslSertifikasiGecerliMi || acikPortlar.contains("23/TELNET");
}

class CihazErisilemezException implements Exception {
  final String mesaj;

  CihazErisilemezException(this.mesaj);

  @override
  String toString() => mesaj;
}

void main() {
  final cihazlar = <IotCihaz>[
    IotCihaz(
      seriNo: "SN-001",
      cihazAdi: "SicaklikSensoru",
      cihazTipi: CihazTipi.sensor,
      cpuYukYuzdesi: 12.5,
      bellekMb: 256,
      acikPortlar: {"1883/MQTT"},
      sslSertifikasiGecerliMi: true,
    ),
    IotCihaz(
      seriNo: "SN-002",
      cihazAdi: "Ana Gateway",
      cihazTipi: CihazTipi.gateway,
      cpuYukYuzdesi: 45.0,
      bellekMb: 1024,
      acikPortlar: {"443/HTTPS", "8883/MQTT"},
      sslSertifikasiGecerliMi: true,
    ),
    IotCihaz(
      seriNo: "SN-003",
      cihazAdi: "Kenar Sunucu",
      cihazTipi: CihazTipi.edgeServer,
      cpuYukYuzdesi: 92.3,
      bellekMb: 4069,
      acikPortlar: {"22/SSH", "443/HTTPS"},
      sslSertifikasiGecerliMi: true,
    ),
    IotCihaz(
      seriNo: "SN-004",
      cihazAdi: "Eski Router",
      cihazTipi: CihazTipi.router,
      cpuYukYuzdesi: 30.0,
      bellekMb: 512,
      acikPortlar: {"23/TELNET", "80/HTTP"},
      sslSertifikasiGecerliMi: true,
    ),
    IotCihaz(
      seriNo: "SN-005",
      cihazAdi: "Kamera Sensörü",
      cihazTipi: CihazTipi.sensor,
      cpuYukYuzdesi: 88.0,
      bellekMb: 128,
      acikPortlar: {"443/HTTPS", "8883/MQTT"},
      sslSertifikasiGecerliMi: false,
    ),
    IotCihaz(
      seriNo: "SN-006",
      cihazAdi: "Yedek Gateway",
      cihazTipi: CihazTipi.gateway,
      cpuYukYuzdesi: 15.0,
      bellekMb: 2048,
      acikPortlar: {"443/HTTPS", "8883/MQTT"},
      sslSertifikasiGecerliMi: false,
    ),
  ];

  final riskliCihazlar = cihazlar
      .where((c) => c.guvenlikAcigiVarMi || c.cpuYukYuzdesi > 85)
      .toList();

  print("=== RİSKLİ CİHAZLAR ===");
  for (final c in riskliCihazlar) {
    print(
      "- ${c.cihazAdi} (${c.seriNo}) → CPU: ${c.cpuYukYuzdesi}% | "
      "Güvenlik açığı: ${c.guvenlikAcigiVarMi}",
    );
  }
  print("Toplam riskli cihaz sayısı: ${riskliCihazlar.length}");

  final toplamBellek = cihazlar.fold<int>(
    0,
    (toplam, c) => toplam + c.bellekMb,
  );
  print("\n=== TOPLAM BELLEK ===");
  print("Ağdaki toplam bellek: $toplamBellek MB");

  (String cihazAdi, CihazTipi tip, bool alarmDurumu) cihazBilgisiGetir(
    String seriNo,
  ) {
    final cihaz = cihazlar.where((c) => c.seriNo == seriNo).firstOrNull;

    if (cihaz == null) {
      throw CihazErisilemezException(
        "HATA: '$seriNo' seri numaralı cihaz ağda bulunamadı!",
      );
    }

    final alarmDurumu = cihaz.guvenlikAcigiVarMi || cihaz.cpuYukYuzdesi > 85;

    return (cihaz.cihazAdi, cihaz.cihazTipi, alarmDurumu);
  }

  print("\n=== CİHAZ SORGULAMA (Record) ===");

  // 1) Var olan bir seri no — başarılı sorgulama
  try {
    final (ad, tip, alarm) = cihazBilgisiGetir("SN-003");
    print("Cihaz: $ad");
    print("Tip: $tip");
    print("Alarm: ${alarm ? "Aktif" : "Yok"}");
  } catch (e) {
    print("Hata: $e");
  }

  // 2) Olmayan bir seri no — exception fırlatacak, catch yakalayacak
  try {
    final (ad, tip, alarm) = cihazBilgisiGetir("SN-999");
    print("Cihaz: $ad | Tip: $tip | Alarm: $alarm");
  } catch (e) {
    print("Hata: $e");
  }
  String izolasyonBolgesi(CihazTipi tip) {
    return switch (tip) {
      CihazTipi.sensor => "ZONE-S",
      CihazTipi.gateway => "ZONE-G",
      CihazTipi.edgeServer => "ZONE-E",
      CihazTipi.router => "ZONE-R",
    };
  }

  print("\n=== İZOLASYON BÖLGELERİ ===");
  for (final c in cihazlar) {
    print(
      "${c.cihazAdi} (${c.cihazTipi.name}) → ${izolasyonBolgesi(c.cihazTipi)}",
    );
  }
}
