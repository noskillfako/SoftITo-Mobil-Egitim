void main(){
  print("Map Metrikleri");

  final Map<String ,Map<String,dynamic>>
  mikroservisRehberi={
    "auth-api":{
      "port": 8881,
      "saglik": "healthy",
      "restartSayisi": 0,
      "bellekkullanimiMB": 384.5,
      "otoolcekleme": true,
    },
    "payment-gateway":{
      "port":8082,
      "saglik":"Degrared",
      "restartSayisi":4,
      "bellekkullanimiMB":1280.0,
      "otoolcekleme":false,
    }

  };
//Yeni servis ekleme (putIfAbsent ile çakışmasını...)
mikroservisRehberi.putIfAbsent(
  "reporting-worker",
  () => {
    "port": 9091,
    "saglik": "Healthy",
    "restartSayisi": 1,
    "bellekKullanimiMB": 512.0,
    "otonomOlcekleme": true,
  },
);
// Metrik güncelleme (update)
if (mikroservisRehberi.containsKey("payment-gateway")) {
  mikroservisRehberi["payment-gateway"]!["restartSayisi"] =
      (mikroservisRehberi["payment-gateway"]!["restartSayisi"] as int) + 1;
}

print("Güncel Servis Durum Raporu");

for (var entry in mikroservisRehberi.entries) {
  final String servis = entry.key;
  final Map<String, dynamic> ozet = entry.value;
  final String saglik = ozet["saglik"] as String;
  final String durumRozet = saglik == "Healthy" ? "ok" : "Alert";

  print("$servis: $saglik - $durumRozet");
}

}