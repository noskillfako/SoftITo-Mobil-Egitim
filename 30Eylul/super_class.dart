class TemelSavasci {
  final String ad;
  final double temelGuc;

  TemelSavasci({
    required this.ad,
    required this.temelGuc,
  });

  void saldir() {
    print("[$ad] Temel Fiziksel Hasar: $temelGuc");
  }
}

class Buyucu extends TemelSavasci {
  int manaPuani;

  Buyucu({
    required this.manaPuani,
    required super.ad,
    required super.temelGuc,
  });

  @override
 void saldir() {
  if (manaPuani >= 10) {
    manaPuani -= 10;
    print(
      "[$ad] Alev Topu Fırlattı: Hasar: ${temelGuc * 2} Kalan Mana:$manaPuani",
    );
  } else {
    print("Mana Tükendi");
    super.saldir();
  }
}
}
class Okcu extends TemelSavasci {
  int okSayisi;

  Okcu({
    required this.okSayisi,
    required super.ad,
    required super.temelGuc,
  });

  @override
  void saldir() {
    if (okSayisi > 0) {
      okSayisi--;
      print("[$ad] Okçuluk Atışı: Hasar: ${temelGuc * 1.5} Kalan Ok: $okSayisi");
    } else {
      print("Ok kalmadı");
      super.saldir();
    }
  }
}

void main(){
  print("Savaş Arenası");
  final asker=TemelSavasci(ad: "Asker", temelGuc: 20);
  asker.saldir();
  print("------------------");
  final merlin=Buyucu(manaPuani: 20, ad: "Emran", temelGuc: 40);
  merlin.saldir();
  print("------------------");
  final legolas=Okcu(okSayisi: 5, ad: "Legolas", temelGuc: 30);
  legolas.saldir();
}