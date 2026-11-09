class EligibilityResult {//uygunluk sonucunu tutan sınıf
  const EligibilityResult({required this.eligible, this.reasons = const []});//kurucu, sebepler başta boş

  final bool eligible;//uygun mu
  final List<String> reasons;//sebep listesi
}

EligibilityResult checkEligibility({//bağış uygunluk kontrolü
  required int age,//yaş zorunlu
  required double weight,//kilo zorunlu
  required bool hasRecentTattoo,//dövme var mı
  required bool hasBlockingDisease,//hastalık var mı
}) {
  final reasons = <String>[];//sebepleri topla
  if (age < 18 || age > 65) {//yaş aralık dışındaysa
    reasons.add('Yaş 18-65 aralığında olmalı.');//sebep ekle
  }
  if (weight < 50) {//kilo azsa
    reasons.add('Kilo en az 50 kg olmalı.');//sebep ekle
  } else if (weight > 150) {//kilo çoksa
    reasons.add('Kilo en fazla 150 kg olmalı.');//sebep ekle
  }
  if (hasRecentTattoo) {//yakın zamanda dövme varsa
    reasons.add('Son 12 ayda dövme yaptırılmamış olmalı.');//sebep ekle
  }
  if (hasBlockingDisease) {//engel hastalık varsa
    reasons.add('Kan bağışına engel bir hastalığınız var.');//sebep ekle
  }
  return EligibilityResult(eligible: reasons.isEmpty, reasons: reasons);//sebep yoksa uygun
}