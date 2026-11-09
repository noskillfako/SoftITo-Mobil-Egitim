import 'dart:math';//rastgele sayı için
import 'package:flutter/material.dart';//widget ve tema için
import '../models/eligibility.dart';//uygunluk kontrolu

class DonationResult {//Bağış sonuçlarıo
  const DonationResult.success([this.message = 'Bağış başarıyla eklendi.'])//başarılıysa default mesaj
      : isSuccess = true,
        reasons = const [];

  const DonationResult.failure(this.reasons, {this.message})//başarısız senaryoda sebepler
      : isSuccess = false;//isSuccess false döner

  final bool isSuccess;//başarılımı
  final String? message;//mesaj
  final List<String> reasons;//sebep listeis
}

class BloodDonationController {//bağışları yöneten sınıf
  BloodDonationController({bool populateInitialData = true}) {//kurucu metod
    if (populateInitialData) {//başta veri dolsun mu
      _generateInitialData();//rastgele veri doldur
    }
  }

  static const List<String> bloodTypes = [//kan grupları
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    '0+',
    '0-',
  ];

  static const List<String> weekDays = [//haftadaki gğnler
    'Pzt',
    'Sal',
    'Çar',
    'Per',
    'Cum',
    'Cmt',
    'Paz',
  ];

  final ValueNotifier<Map<String, int>> counts =//kan gruplarını tutmak için
      ValueNotifier<Map<String, int>>({for (final t in bloodTypes) t: 0});

  final ValueNotifier<Map<String, int>> weeklyCounts =//haftadaki günleri tutmak için
      ValueNotifier<Map<String, int>>({for (final d in weekDays) d: 0});

  final ValueNotifier<String?> selectedType = ValueNotifier<String?>(null);//seçili kan grubunu tutar başta null değer

  final ValueNotifier<ThemeMode> themeMode =//tema modu başta açık mod
      ValueNotifier<ThemeMode>(ThemeMode.light);

  int get totalDonations =>//toplam bağıi
      counts.value.values.fold<int>(0, (sum, count) => sum + count);//tüm değerleri toplar

  void _generateInitialData() {//rastgele veri üretimi
    final random = Random();//random üretici
    final initialCounts = <String, int>{};//kan grubu başlangıç mapi
    final initialWeekly = <String, int>{};//günlük başlangıç mapi

    // Realistic initial distribution across 8 blood types
    for (final type in bloodTypes) {//her kan grubu için dön
      initialCounts[type] = 2 + random.nextInt(5); // 2 ile 6 arası rastgele sayı
    }

    // Realistic initial distribution across 7 days of the week
    for (final day in weekDays) {//her gün için dön
      initialWeekly[day] = 3 + random.nextInt(6); // 3 ile 8 arası rastgele bir sayı
    }

    counts.value = initialCounts;//map güncelelme
    weeklyCounts.value = initialWeekly;//map güncelleme
  }

  void toggleTheme() {//tema değişimi
    themeMode.value =
        themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;//dark ise light, light ise dark yap
  }

  void selectType(String? type) {//kan grubu seç
    selectedType.value = type;//seçili tipi güncelle
  }

  void reset() {//resetleme fonk
    counts.value = {for (final t in bloodTypes) t: 0};//hepsini sıfırla
    weeklyCounts.value = {for (final d in weekDays) d: 0};//günleri sıfırla
  }

  DonationResult addDonation({//bağış ekleme
    required String? rawAge,//yaş kaç
    required String? rawWeight,//kilo kaç
    required bool hasRecentTattoo,//dövme var mı
    required bool hasBlockingDisease,//hastalık var mı
    String? day,//habngfi gün
  }) {
    final reasons = <String>[];//sebepelri topla

    final type = selectedType.value;//seçili tip
    if (type == null || type.isEmpty) {//tip seçilmemişse
      reasons.add('Kan grubu seçin.');//kan grubu seç
    }

    final trimmedAge = rawAge?.trim() ?? '';//trimle boşluk birleştirme
    final trimmedWeight = rawWeight?.trim().replaceAll(',', '.') ?? '';//virgül ve nokta ekle

    final age = int.tryParse(trimmedAge);//yaşa çevir
    final weight = double.tryParse(trimmedWeight);//kiloya çevir

    if (age == null || weight == null) {//sayı değilse
      reasons.add('Yaş ve kilo geçerli sayı olmalı.');//hata ekle
    } else {//sayıysa uygunluk kontrolü yap
      final eligibility = checkEligibility(//uygunluk fonksiyonu çağır
        age: age,
        weight: weight,
        hasRecentTattoo: hasRecentTattoo,
        hasBlockingDisease: hasBlockingDisease,
      );
      if (!eligibility.eligible) {//uygun değilse
        reasons.addAll(eligibility.reasons);//sebepleri listeye ekle
      }
    }

    if (reasons.isNotEmpty) {//sebep varsa
      return DonationResult.failure(reasons);//başarısız dön
    }

    // Default to current weekday if not specified
    final targetDay = day ?? weekDays[(DateTime.now().weekday - 1) % 7];//gün verilmemişse bugünü al

    // Immutable update of maps
    counts.value = {//kan grubu sayısını arttır
      ...counts.value,//eskisini kopyala
      type!: counts.value[type]! + 1,//seçili tipi 1 arttır
    };

    weeklyCounts.value = {//günlük sayıyı arttır
      ...weeklyCounts.value,//eskisini kopyala
      targetDay: (weeklyCounts.value[targetDay] ?? 0) + 1,//o günü 1 arttır
    };

    return DonationResult.success('$type kan grubu bağışı eklendi.');//başarılı mesaj dön
  }

  void dispose() {//temizlik fonksiyonu
    counts.dispose();//dinleyiciyi kapat
    weeklyCounts.dispose();//bunu da kapat
    selectedType.dispose();//seçili tipi kapat
    themeMode.dispose();//tema modunu kapat
  }
}