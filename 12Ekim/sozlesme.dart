import 'dart:async';

//Soyutlama absatratc kavramı

/*abstract class AutReposity(soyut sınıf doğrudan örneklenmez sadece miras alır onun tanınlanması) {
  Future<String>login(String email,String password)//Future ile string çağırılan giriş yap metodu;
  Future<void>logout()//future ile çağırılan çıkış yap metodu void olduğu için değer döndürmez;
  bool get isAuth//giriş yapılıp yapılmadığını öğrenmek için tanımlanan isAuth metodu get olmasının sebebi de dışardan okunabilir ama yazılamaz olması;
}

class FirebaseAuthReposity implements AutReposity//AuthReposity'i implement eder{
  @override//üstteki metodu ezmek için kullanılır
  Future<String>login(String email, String password) async//Future string olarak tanımlanan giriş yap metodu{
    return "firebase_token_xyz_123";//programın sonunda dönüş için üretilen sahte token
  }

  @override//üst metodu ezmek için kullanılır
  Future<void>logout() async{//Future void olarak tanımlanan çıkış işlemi
    //firebase logout işlemleri
  }

  @override//üst metodu ezmek için
  bool get isAuth => true;//girişi doğrulama 
}

//test ve offline simülasyon
class MockAuthReposity implements AutReposity{//implement işlemi
  @override //üst metodu ezmek için kullanılır
  Future<String>login (String email,String password) async{//Future string olarak giriş işlemi için email ve password tanımlama
    return "mock_token_abc_789";//rastgele bir mock veri ile program çıktısı
  }

  @override//üst metodu ezmek
  Future<void>logout() async{}//hesaptan çıkış metodu
 @override //üsdt metodu ezmek için
  bool get isAuth => false;//girişi false yani giriş yapılamadı demek
ß
}
*/

/*
mixin Logger{
  void log(String msg)=>print("LOG: $msg");
}

mixin Analytics{
  void log(String msg)=>print("ANALİZ: $msg");
}

class PaymentService with Logger,Analytics{//mixin ile yeni özellikler tanımlandı ve with ile de o yeni özellikler paymentservice metoduna aktarıldı
  void pay(){//ödeme fonksiyonu
    log("Ödeme yapıldı");//çıktı
  }
}

abstract class BaseWidget{

}

//sadece BaseWidget ve alt sınıflarda. kullanabilir

mixin LifeLogger on BaseWidget{
  void logInit ()=>print("Widget başlatıldı");
}


extension StringValidator on String{//Stringe yeni metodlar ewklemek için extansion
  bool get isValidEmail{//RegExp kontrolu
    final emailRegex=RegExp('dfgdfgngfnfgdfbhnhfnh&+%+^^6767343245%&%+&2');//
    return emailRegex.hasMatch(this);//Regex uyuyor mu uymuyor mu
  }
  String toCapitalize(){
    if(isEmpty) return this;//string boş mu kontrolu
    return this[0].toUpperCase()+substring(1);//this[0] stringin ilk indexini alır touppercase ilk indexi büyütür substringde kalan harfleri birleştirir
  }
}

//Kullanım
void main(){
  String email="selahaddin@kodvance.com";
  if(email.isValidEmail){//email geçerli mi sorgusu
    print("Geçerli email");
  }else{
    print("Geçersiz email");  
  }
}


abstract class Identifiable{//soyut sınıf
  String get id;
}
class GenericCache<T extends Identifiable>{//T herhangi bir tip olamaz sadece Identifiableı implement eden tipler olabilir
  final Map<String,T>_storage={};//baştaki alt çizgi private yani sadece bu sınıfta ulaşılabilir demek {}'da boş map ile başaldığını gösterir

  void save (T item){//nesnin ıdsinin alır
    _storage[item.id]=item;//map'a atama yapılır
    print("ID: (${item.id}) önbelleğe atıldı");//bilgilendirme mesajı
  }
  T? getByIdd(String id)=> _storage[id];
}
*/

void main(){
  //print olarak yazıldığı için 1.sırada direkt işlem
  print("1.Senkron başladı");
  //schedulemicrotask olarak yazıldığı için 3.sırada
  scheduleMicrotask((){
    print("2.Task Oluştu(Vip. Kuyruk)");
  });
  //future olduğu için 5.sırada
  Future((){
    print("3.Standart Event kuyruğu");
  });
  //microtask olduğu için 4.sırada
  Future.microtask((){
    print("4.Future.microtask calisti");
  });
  //print olarak yazıldığı için 2.sırada 2.sırada işelm
  print("5.Senkron kod tamamlandı");
}