class CloudException implements Exception {
  final String hataKodu;
  final String mesaj;
  final DateTime zaman = DateTime.now();

  CloudException(this.hataKodu, this.mesaj);

  @override
  String toString() => "[$hataKodu] $mesaj ($zaman)";
}

class CpuOverload extends CloudException {
  final double mevcutCpu;
  final double limit;

  CpuOverload({
    required this.mevcutCpu,
    required this.limit,
  }) : super("Err_cpu_overload", "Cpu kullanimi eşik limitini ($limit) aşti: $mevcutCpu%");
}
class NodeUnavailable extends CloudException {
  final String nodeId;
  NodeUnavailable(this.nodeId)
      : super("Err_node_ofline", "Yanıt vermiyor: $nodeId");
}
void podKaynagiTahsisEt(String podAdi, double talepEdilenCpu, double sistemKalanCpu) {
  if (talepEdilenCpu <= 0) {
    throw CloudException("Err_invalid_param", "Talep Edilen cpu pozitif bir değer olmalıdır.");
  }

  if (talepEdilenCpu > sistemKalanCpu) {
    throw CpuOverload(mevcutCpu: 100 - sistemKalanCpu + talepEdilenCpu, limit: 100.0);
  }

  print("Pod [$podAdi] başarıyla tahsis edildi:Kalan boş cpu: ${sistemKalanCpu - talepEdilenCpu}%");
}
void main(){
  print("Yönetim Paneli");
  try{
    podKaynagiTahsisEt("ingress-controller",15.0, 40.0);
  }catch(e){
    print("Hata: $e");
  }

 try {
  podKaynagiTahsisEt("ai-training-pd", 75.0, 20.0);
} on CpuOverload catch (e) {
  print("Cpu hatasi yakalandi");
  print("Hata kodu: ${e.hataKodu}");
  print("Mesaj: ${e.mesaj}");
  print("Aksiyon: Otomatik Aws Açma isteği Gönderildi");
} on CloudException catch (e) {
  print("Bulut hatasi: ${e.mesaj}");
} catch (e, stackTrace) {
  print("Bilinmedik Sistem Hatasi $e");
} finally {
  print("Pod tahsis günlüğü kapatildi.");
}
}