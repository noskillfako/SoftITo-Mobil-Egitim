abstract class LoncaUyesi {
  final String rumuz;

  LoncaUyesi({
    required this.rumuz,
  });
  void ozelYetenekKullan();

  void loncaSelamVer(){
    print("$rumuz Lonca bayrağina selam");
  }
}

class sovalye extends LoncaUyesi{
sovalye({required super.rumuz});

@override
void ozelYetenekKullan(){
  print("$rumuz Demir kalkani kullandi");
}
}

class sifaci extends LoncaUyesi{
  sifaci({required super.rumuz});

  @override
  void ozelYetenekKullan(){
    print("$rumuz Şifa kullanarak tüm takıma can bastı");
  }
}
void savasAlanindaKomutVer(List<LoncaUyesi> takim) {
  print("Liderin Emriyle Takım Yetenekleri Devreye Girsin");
  for (var t in takim) {
    t.loncaSelamVer();
    //Herkes kendi özel yeteneğini kullansın
    t.ozelYetenekKullan();
  }
}
void main() {
  print("Lonca Takımı");
  final List<LoncaUyesi> loncaBirligi = [
    sovalye(rumuz: "Kızıl Şövalye"),
    sifaci(rumuz: "Orman Perisi"),
    sovalye(rumuz: "Gümüş Muhafız"),
  ];
  savasAlanindaKomutVer(loncaBirligi);
}
