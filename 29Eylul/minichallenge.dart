void main(){
  Set<String> serviceSet={
    "api-servisi",
    "kimllikdogrulama-servisi",
    "kullanici-servisi",
    "odeme-servisi"
  };
  bool isProduction=true;
  if(isProduction){
    serviceSet.add("gizli-yönetici");
  }

  List<String> serviceList=serviceSet.toList();
  print(serviceList);
}