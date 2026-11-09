import 'package:flutter/material.dart';//material kütüphanesi
import '../controllers/blood_donation_controller.dart';//bağış kontrolcüsü
import '../widgets/blood_type_selector.dart';//kan grubu seçici widget

class AddDonationView extends StatefulWidget {//bağış ekleme ekranı
  const AddDonationView({super.key, required this.controller});//key ve controller zorunlu

  final BloodDonationController controller;//dışarıdan gelen controller

  @override
  State<AddDonationView> createState() => _AddDonationViewState();//state üret
}

class _AddDonationViewState extends State<AddDonationView> {
  final TextEditingController _ageController = TextEditingController();//yaş girişi kontrolcüsü
  final TextEditingController _weightController = TextEditingController();//kilo girişi kontrolcüsü

  bool _hasRecentTattoo = false;//dövme var mı, başta yok
  bool _hasBlockingDisease = false;//hastalık var mı, başta yok

  @override
  void dispose() {//sayfa kapanınca
    _ageController.dispose();//yaş kontrolcüsünü temizle
    _weightController.dispose();//kilo kontrolcüsünü temizle
    super.dispose();
  }

  void _submitDonation() {//bağışı gönder
    final result = widget.controller.addDonation(//controller'a gönder
      rawAge: _ageController.text,//yaş metni
      rawWeight: _weightController.text,//kilo metni
      hasRecentTattoo: _hasRecentTattoo,//dövme durumu
      hasBlockingDisease: _hasBlockingDisease,//hastalık durumu
    );

    if (result.isSuccess) {//başarılıysa
      ScaffoldMessenger.of(context).showSnackBar(//snackbar göster
        SnackBar(
          content: Row(//ikon + yazı yanyana
            children: [
              const Icon(Icons.check_circle, color: Colors.white),//onay ikonu
              const SizedBox(width: 8),//boşluk
              Expanded(//kalan alanı kapla
                child: Text(result.message ?? 'Bağış başarıyla eklendi.'),//mesaj
              ),
            ],
          ),
          backgroundColor: const Color(0xFF00C853),//renk değişir
          behavior: SnackBarBehavior.floating,//yüzen bildirim
        ),
      );
    } else {//başarısızsa
      _showReasonsDialog(result.reasons);//sebepleri göster
    }
  }

  void _showReasonsDialog(List<String> reasons) {//sebep diyaloğu
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(//uyarı kutusu
        icon: const Icon(Icons.error_outline, color: Color(0xFFFF1744), size: 36),//hata ikonu
        title: const Text(
          'Bağış Eklenemedi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(//sebepleri listele
          mainAxisSize: MainAxisSize.min,//içeriğe göre boyut
          crossAxisAlignment: CrossAxisAlignment.start,//sola yasla
          children: [
            const Text(
              'Aşağıdaki sebeplerden dolayı bağış kabul edilemedi:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),//boşluk
            ...reasons.map(//her sebep için
              (reason) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),//dikey boşluk
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,//sola yasla
                  children: [
                    const Text(
                      '• ',//madde işareti
                      style: TextStyle(
                        color: Color(0xFFFF1744),//renk değişir
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(//kalan alanı kapla
                      child: Text(
                        reason,//sebep yazısı
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          FilledButton(//kapat butonu
            onPressed: () => Navigator.of(ctx).pop(),//kapat
            child: const Text('Anladım'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);//temayı al
    final colorScheme = theme.colorScheme;//renk şemasını al

    return Scaffold(//ana sayfa
      appBar: AppBar(//üst bar
        title: Row(//ikon + başlık yanyana
          mainAxisSize: MainAxisSize.min,//içeriğe göre
          children: [
            ClipRRect(//resmi yuvarlak köşeli yap
              borderRadius: BorderRadius.circular(8),//köşe yuvarlak
              child: Image.asset(//resmi yükle
                'assets/images/app_icon.png',//resim yolu
                width: 28,//genişlik
                height: 28,//yükseklik
                fit: BoxFit.cover,//kapla
              ),
            ),
            const SizedBox(width: 10),//boşluk
            const Text('Bağış Ekle'),//başlık yazısı
          ],
        ),
        centerTitle: true,//ortala
        actions: [//sağdaki ikonlar
          ValueListenableBuilder<ThemeMode>(//tema modunu dinle
            valueListenable: widget.controller.themeMode,//dinlenecek değer
            builder: (context, mode, _) {//değişince çalışır
              final isDark = mode == ThemeMode.dark;//karanlık mı
              return IconButton(
                tooltip: isDark ? 'Açık Mod' : 'Karanlık Mod',//ipucu
                icon: Icon(//tema ikonu
                  isDark ? Icons.light_mode : Icons.dark_mode_outlined,//karanlıksa güneş, değilse ay
                  color: isDark ? const Color(0xFFFFD600) : null,//renk değişir
                ),
                onPressed: widget.controller.toggleTheme,//tıklayınca tema değiştir
              );
            },
          ),
        ],
      ),
      body: SafeArea(//güvenli alan
        child: Column(//alt alta
          children: [
            Expanded(//kalan alanı kapla
              child: SingleChildScrollView(//kaydırılabilir
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),//iç boşluk
                child: Column(//alt alta
                  crossAxisAlignment: CrossAxisAlignment.stretch,//tam genişlik
                  children: [
                    Text(
                      'Kan Grubu Seçin',//başlık
                      style: theme.textTheme.titleMedium?.copyWith(//tema yazı stili
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),//boşluk
                    ValueListenableBuilder<String?>(//seçili tipi dinle
                      valueListenable: widget.controller.selectedType,//dinlenecek
                      builder: (context, selectedType, _) {//değişince çalışır
                        return BloodTypeSelector(//kan grubu seçici
                          bloodTypes: BloodDonationController.bloodTypes,//tüm tipler
                          selectedType: selectedType,//seçili olan
                          onTypeSelected: widget.controller.selectType,//seçilince çağır
                        );
                      },
                    ),
                    const SizedBox(height: 24),//boşluk
                    Text(
                      'Kişisel Bilgiler',//başlık
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),//boşluk
                    Row(//yaş ve kilo yanyana
                      children: [
                        Expanded(//yarım alan
                          child: TextField(//yaş girişi
                            controller: _ageController,//kontrolcü
                            keyboardType: TextInputType.number,//sayı klavyesi
                            decoration: InputDecoration(//giriş süslemesi
                              labelText: 'Yaş',//etiket
                              hintText: 'Örn. 25',//ipucu
                              helperText: '18 - 65 yaş',//yardım yazısı
                              prefixIcon: Icon(Icons.cake_outlined, color: colorScheme.primary),//pasta ikonu
                              border: const OutlineInputBorder(),//kenarlık
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),//boşluk
                        Expanded(//diğer yarım alan
                          child: TextField(//kilo girişi
                            controller: _weightController,//kontrolcü
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),//ondalık klavye
                            decoration: InputDecoration(//giriş süslemesi
                              labelText: 'Kilo (kg)',//etiket
                              hintText: 'Örn. 70',//ipucu
                              helperText: '50 - 150 kg',//yardım yazısı
                              prefixIcon: Icon(Icons.monitor_weight_outlined, color: colorScheme.primary),//tartı ikonu
                              border: const OutlineInputBorder(),//kenarlık
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),//boşluk
                    Text(
                      'Uygunluk Durumu',//başlık
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),//boşluk
                    Card(//kart kutusu
                      elevation: 0,//gölge yok
                      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),//renk değişir
                      shape: RoundedRectangleBorder(//köşe şekli
                        borderRadius: BorderRadius.circular(14),//köşe yuvarlak
                        side: BorderSide(//kenarlık
                          color: colorScheme.outlineVariant.withValues(alpha: 0.5),//renk değişir
                        ),
                      ),
                      child: Column(//alt alta
                        children: [
                          CheckboxListTile(//dövme sorusu
                            value: _hasRecentTattoo,//değer
                            activeColor: colorScheme.primary,//seçili renk
                            onChanged: (val) {//değişince
                              setState(() => _hasRecentTattoo = val ?? false);//state güncelle
                            },
                            title: const Text(
                              'Son 12 ayda dövme yaptırdım',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,//kutuyu sola al
                          ),
                          const Divider(height: 1),//ayırıcı çizgi
                          CheckboxListTile(//hastalık sorusu
                            value: _hasBlockingDisease,//değer
                            activeColor: colorScheme.primary,//seçili renk
                            onChanged: (val) {//değişince
                              setState(() => _hasBlockingDisease = val ?? false);//state güncelle
                            },
                            title: const Text(
                              'Kan bağışına engel bir hastalığım var',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,//kutuyu sola al
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),//boşluk
                    FilledButton.icon(//dolu buton ikonlu
                      onPressed: _submitDonation,//tıklayınca gönder
                      icon: const Icon(Icons.add_task),//ekle ikonu
                      label: const Text(
                        'Bağış Ekle',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: FilledButton.styleFrom(//buton stili
                        backgroundColor: colorScheme.primary,//renk değişir
                        foregroundColor: Colors.white,//renk değişir
                        padding: const EdgeInsets.symmetric(vertical: 16),//dikey boşluk
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),//köşe yuvarlak
                        ),
                        elevation: 3,//hafif gölge
                        shadowColor: colorScheme.primary.withValues(alpha: 0.5),//renk değişir
                      ),
                    ),
                    const SizedBox(height: 16),//boşluk
                  ],
                ),
              ),
            ),
            // Altta sabit uyarı: "Eğitim amaçlı uygulamadır, gerçek karar Kızılay doktorundadır."
            Container(//alt uyarı kutusu
              width: double.infinity,//tam genişlik
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),//iç boşluk
              decoration: BoxDecoration(//süsleme
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),//renk değişir
                border: Border(//kenarlık
                  top: BorderSide(//üst kenarlık
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),//renk değişir
                  ),
                ),
              ),
              child: Row(//ikon + yazı yanyana
                children: [
                  Icon(Icons.info_outline, size: 20, color: colorScheme.primary),//bilgi ikonu
                  const SizedBox(width: 10),//boşluk
                  const Expanded(//kalan alani kapla
                    child: Text(
                      'Eğitim amaçlı uygulamadır, gerçek karar Kızılay doktorundadır.',//uyari yazisi
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}