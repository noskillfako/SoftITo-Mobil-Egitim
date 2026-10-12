import 'dart:async';

//Soyutlama absatratc kavramı

/*abstract class AutReposity {
  Future<String>login(String email,String password);
  Future<void>logout();
  bool get isAuth;
}

class FirebaseAuthReposity implements AutReposity{
  @override
  Future<String>login(String email, String password) async{
    return "firebase_token_xyz_123";
  }

  @override
  Future<void>logout() async{
    //firebase logout işlemleri
  }

  @override
  bool get isAuth => true;
}

//test ve offline simülasyon
class MockAuthReposity implements AutReposity{
  @override 
  Future<String>login (String email,String password) async{
    return "mock_token_abc_789";
  }

  @override
  Future<void>logout() async{}
 @override 
  bool get isAuth => false;
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

class PaymentService with Logger,Analytics{
  void pay(){
    log("Ödeme yapıldı");
  }
}

abstract class BaseWidget{

}

//sadece BaseWidget ve alt sınıflarda. kullanabilir

mixin LifeLogger on BaseWidget{
  void logInit ()=>print("Widget başlatıldı");
}


extension StringValidator on String{
  bool get isValidEmail{
    final emailRegex=RegExp('dfgdfgngfnfgdfbhnhfnh&+%+^^6767343245%&%+&2');
    return emailRegex.hasMatch(this);
  }
  String toCapitalize(){
    if(isEmpty) return this;
    return this[0].toUpperCase()+substring(1);
  }
}

//Kullanım
void main(){
  String email="selahaddin@kodvance.com";
  if(email.isValidEmail){
    print("Geçerli email");
  }else{
    print("Geçersiz email");  
  }
}


abstract class Identifiable{
  String get id;
}
class GenericCache<T extends Identifiable>{
  final Map<String,T>_storage={};

  void save (T item){
    _storage[item.id]=item;
    print("ID: (${item.id}) önbelleğe atıldı");
  }
  T? getByIdd(String id)=> _storage[id];
}
*/

void main(){
  print("1.Senkron başladı");
  scheduleMicrotask((){
    print("2.Task Oluştu(Vip. Kuyruk)");
  });
  Future((){
    print("3.Standart Event kuyruğu");
  });
  Future.microtask((){
    print("4.Future.microtask calisti");
  });
  print("5.Senkron kod tamamlandı");
}