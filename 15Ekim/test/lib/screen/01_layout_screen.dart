//icon kullanımı için projeye kutuphane dahil eder
import 'package:flutter/material.dart';

//layoutstylingscreen sınıfına tutulacak statefulwidget ekler
class LayoutStylingScreen extends StatefulWidget {
  //üst sınıfın key parametresini alır
  const LayoutStylingScreen({super.key});

  //üst metodu ezer
  @override
  //state nesnesi üretir
  State<LayoutStylingScreen> createState() => _LayoutStylingScreenState();
}

//state sınıfı oluşturma private
class _LayoutStylingScreenState extends State<LayoutStylingScreen> {
  //bakiyenin görünüp görünmemesini tutan değişken
  bool _isBalanceVisible = true;
  //
  String _lastAction = 'Hazır - Butonlara Tıklayabilirsiniz';

//üst metodu ezer
  @override
  //UI çizmek için çağırılan metod
  Widget build(BuildContext context) {
    //içeriği kaydırılabilir yapar
    return SingleChildScrollView(
      //kaydırma fiziği
      physics: const BouncingScrollPhysics(),
      //iç boşluk
      padding: const EdgeInsets.only(bottom: 32),
      //dikey sıralama için child
      child: Column(
        //sola hizlama
        crossAxisAlignment: CrossAxisAlignment.start,
        //children çağrıları
        children: [
          _buildProfileHeader(),//profil başlığı
          _buildWalletCard(),//cüzdfan kart bölümü
          _buildQuickActions(),//hızlı işlemler
          _buildFlexStatistics(),//istatistik
          _buildNotificationBanner(),//bildirim kısmı

          // Canlı Durum Bildirimi
          Center(//ortalama
            child: Padding(
              padding: const EdgeInsets.all(16.0),//her bir taraftan 16px boşluk
              child: Text(
                'Son İşlem: $_lastAction',
                style: const TextStyle(//Text stili
                  fontSize: 13,//font büyüklüğ
                  color: Color(0xFF64748B),//font rengi
                  fontStyle: FontStyle.italic,//font biçimi
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROFİL BAŞLIĞI
  // ============================================================
  Widget _buildProfileHeader() {
    return Container(//container açılımı
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),//iç boşlukların sol üst sağ alt değerleri
      child: Row(//row açılımı
        children: [//children açılımı
          const CircleAvatar(//avatar yuvarlak bir görünüm elde etmek için açılan fonksiyon
            radius: 28,//yarıçapı 28px
            backgroundColor: Color(0xFF6366F1),//arka plan rengi
            child: Icon(Icons.person, color: Colors.white, size: 32),//icon görünümü
          ),
          const SizedBox(width: 14),//avatar ile metin arasında boşluk 14px
          const Expanded(//esnek genişlik vermesi açısından
            child: Column(//dikey
              crossAxisAlignment: CrossAxisAlignment.start,//metinleri sola hizalar
              children: [
                Text(
                  'Merhaba, DTM Öğrencisi 👋',
                  style: TextStyle(//text stili
                    fontSize: 18,//text büyüklüğü
                    fontWeight: FontWeight.bold,//kalın metin
                    color: Color(0xFF0F172A),//text rengi
                  ),
                ),
                SizedBox(height: 4),//boşluk
                Text(
                  'Bugün harika bir gün!',
                  style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),//text işlemleri
                ),
              ],
            ),
          ),
          IconButton(//ikon butonu
            icon: const Icon(Icons.settings_outlined),//ayarlar şkonu
            color: const Color(0xFF64748B),//rengi
            onPressed: () {//basıldığı zaman yapacağı işlerimi yazan fonk
              setState(() {//yeni bir setstate açılır
                _lastAction = 'Ayarlar butonuna basıldı ⚙️';//son metinler işlemlerini günceller
              });
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CÜZDAN KARTI
  // ============================================================
  Widget _buildWalletCard() {
    return Container(//container
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),//yatay dikey dış boşluk
      padding: const EdgeInsets.all(20),//iç boşluk
      decoration: BoxDecoration(//decoration
        gradient: const LinearGradient(//doğrusal renk geçişi
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],//renk
          begin: Alignment.topLeft,//başlangıç noktası
          end: Alignment.bottomRight,//bitiş noktası
        ),
        borderRadius: BorderRadius.circular(20),//köşe yuvarlıklığı
        boxShadow: [//gölge ayarı için
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.35),//renk ve opaklığı ayarlamak için
            blurRadius: 20,//bulanıklık
            offset: const Offset(0, 8),//gölgenin kayma miktarı
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,//sol taraftan başlama
        children: [
          Row(//toplam bakiye
            mainAxisAlignment: MainAxisAlignment.spaceBetween,//çocuklar arası boşluk
            children: [
              const Text(
                'Toplam Bakiye',
                style: TextStyle(//toplam bakşye yazısı ayarları
                  color: Colors.white70,//%70 opaklık
                  fontSize: 14,
                  fontWeight: FontWeight.w500,//kalınlık ayarı
                ),
              ),
              IconButton(//ıcon butonu
                icon: Icon(
                  _isBalanceVisible//state true ise göz açık false ise kapalı
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.white,//renk beyaz
                ),
                onPressed: () {//basıldığı zaman
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;//bakiye gizlendi veya açıldı fonksiyonu
                    _lastAction = _isBalanceVisible//son işlem değişti
                        ? 'Bakiye görünür yapıldı 👁️'
                        : 'Bakiye gizlendi 🙈';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),//8px boşluk
          Text(
            _isBalanceVisible ? '₺ 12.450,80' : '₺ ••••••',//isBalanceVisible'a göre bakiye görünür veya gizlenir
            style: const TextStyle(
              color: Colors.white,//beyaz renk
              fontSize: 28,//font büyüklüğü
              fontWeight: FontWeight.bold,//font kalınlığı
              letterSpacing: 0.5,//harfler arası boşluk
            ),
          ),
          const SizedBox(height: 16),//16px görünmez kutu
          Row(
            children: [
              _buildMiniChip(Icons.arrow_upward, 'Gelir', '+₺2.100'),//yukarı oklu gelir çipi
              const SizedBox(width: 10),//boşluk 10 px
              _buildMiniChip(Icons.arrow_downward, 'Gider', '-₺890'),//aşağı oklu gider çip
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniChip(IconData icon, String label, String value) {
    return Container(//chip kutusu
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),//simetrik yatay ve dikey iç boşluk
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),//beyaz %15 saydam arka plan
        borderRadius: BorderRadius.circular(10),//10px yuvarlak köşe
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 14),//ikon renk
          const SizedBox(width: 6),//boşluk
          Text(
            '$label $value',//birleşik metin
            style: const TextStyle(color: Colors.white, fontSize: 12),//text renk ve büyüklüğü
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HIZLI İŞLEMLER
  // ============================================================
  Widget _buildQuickActions() {//widget oluşturma
    final actions = [//yerel değişkenler
      {'icon': Icons.send_outlined, 'label': 'Gönder'},//gönder ikonu
      {'icon': Icons.download_outlined, 'label': 'Al'},//indir ikonu
      {'icon': Icons.qr_code_scanner, 'label': 'QR Tara'},//qr tarayıcı
      {'icon': Icons.more_horiz, 'label': 'Daha'},//üç nokta
    ];

    return Padding(//iç boşluk ekleme
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),//simetrik yatay 20 dikey 8 px boşluk
      child: Column(//dikey sıralama
        crossAxisAlignment: CrossAxisAlignment.start,//soldan başlama
        children: [
          const Text(//text işlemleri
            'Hızlı İşlemler',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),//12px boşluk
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,//butonları eşit aralıkalr sıralar
            children: actions.map((action) {//her action elemanını widgeta dönüştürür
              return _buildQuickActionButton(
                action['icon'] as IconData,//icon degerini alıp tip döonüsüümö yapar
                action['label'] as String,//label degerini string alır
              );
            }).toList(),//map'i list'e çevirir
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label) {
    return InkWell(//yağmur damlası efekti
      borderRadius: BorderRadius.circular(14),//köşe yuvarlıklığı
      onTap: () {//tıklandığında
        setState(() {//yeni setstate oluşturur
          _lastAction = '$label işlemi seçildi ✅';//son yapılanalr güncellenir
        });
      },
      child: Column(
        children: [
          Container(//container
            width: 56,//genişlik 56
            height: 56,//yükseklik 56
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),//arka pan rengi
              borderRadius: BorderRadius.circular(14),//köşerli 14px yuvarlamaca
            ),
            child: Icon(icon, color: const Color(0xFF6366F1)),//ikon rengi
          ),
          const SizedBox(height: 6),//6px boşluk
          Text(
            label,//buton etiketi
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),//12px gri metin
          ),
        ],
      ),
    );
  }

  // ============================================================
  // İSTATİSTİKLER (FLEX)
  // ============================================================
  Widget _buildFlexStatistics() {//istatistik widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),//yatay 20px dikey 12px iç boşluk
      child: Row(//iki kartı yatay sıralar
        children: [
          Expanded(child: _buildStatCard('Bu Ay Gelir', '₺ 8.450', Icons.trending_up, Colors.green)),//yarım kalan alan kaplanır esneklenir yukarı ok yeşil
          const SizedBox(width: 12),//boşluk
          Expanded(child: _buildStatCard('Bu Ay Gider', '₺ 3.220', Icons.trending_down, Colors.redAccent)),//yarım kalan alan kaplanır esneklenir aşağı ok kırmzıı
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(//kart kutusu
      padding: const EdgeInsets.all(16),//iç boşluk 16px
      decoration: BoxDecoration(//kutu dekorasyon
        color: Colors.white,//beyaz
        borderRadius: BorderRadius.circular(16),//köşeler 16px
        border: Border.all(color: const Color(0xFFE2E8F0)),//kenar rengi
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,//soldan başlama
        children: [
          Row(//ikon+başlık
            children: [
              Icon(icon, color: color, size: 18),//boyut 18 renkli buton
              const SizedBox(width: 6),//6px boşluk
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),//12px gri
              ),
            ],
          ),
          const SizedBox(height: 10),//10px dikey boşluk
          Text(
            value,
            style: const TextStyle(//değer metni ayarları
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BİLDİRİM BANNER'I
  // ============================================================
  Widget _buildNotificationBanner() {//bildirim banneri
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),//dış boşluk
      padding: const EdgeInsets.all(16),//iç boşluk
      decoration: BoxDecoration(//box dekorasyon
        color: const Color(0xFFFFF7ED),//beyaz
        borderRadius: BorderRadius.circular(14),//14px yuvarlama
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),//iç boşluk
            decoration: const BoxDecoration(
              color: Color(0xFFFED7AA),
              shape: BoxShape.circle,//tam daire şekli
            ),
            child: const Icon(
              Icons.notifications_active_outlined,//aktif bildirim butonu
              color: Color(0xFFEA580C),//renk
              size: 20,//boyut
            ),
          ),
          const SizedBox(width: 12),//boşluk
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,//sol taraftan başalngıç
              children: [
                Text(
                  'Yeni Bildirim',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,//kalın yazı
                    fontSize: 14,//14px büyüklük
                    color: Color(0xFF9A3412),//renk
                  ),
                ),
                SizedBox(height: 2),//2px boşluk
                Text(
                  'Kartınızın son kullanma tarihi yaklaşıyor.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF9A3412)),//text ayaralrı
                ),
              ],
            ),
          ),
          IconButton(//ikon butonu
            icon: const Icon(Icons.close, size: 18, color: Color(0xFF9A3412)),//ikon renl boyut
            onPressed: () {//basıldığında
              setState(() {//yeni setstate üretilir
                _lastAction = 'Bildirim kapatıldı ❌';//son yapılanalra eklenir
              });
            },
          ),
        ],
      ),
    );
  }
}