import 'package:flutter/material.dart';//material kutuphanesi lazm
import '../models/transation_model.dart' as transaction_model;//işlem modeli buradan geliyo

class TransferFormScreen extends StatefulWidget {//stateful widget yaptk
  const TransferFormScreen({super.key});//key alıyoz

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();//state olusturuyo
}

class _TransferFormScreenState extends State<TransferFormScreen> {

  // ============================================================
  // STATE
  // ============================================================
  double _balance = 149950.00;//başlangıç bakiyesi

  final TextEditingController _ibanController = TextEditingController();//iban yazılan yerin kontrolu
  final TextEditingController _amountController = TextEditingController();//tutar yazılan yerin kontrolu

  //başta gelen 2 işlem var burada
  final List<transaction_model.TransactionItem> _history = [
    // ---- 1. İŞLEM (Gelen Transfer)
    const transaction_model.TransactionItem(
      id: 'tx_init_1',
      title: 'Ahmet Yılmaz',
      category: 'Hızlı Transfer',
      date: 'Bugün 11:30',
      amount: 1500.00,
      isExpense: true,//gider yani para gidiyo
      icon: Icons.send_rounded,//gönderme ikonu
    ),

    // ---- 2. İŞLEM (DÜZENLENDİ - Farklı alıcı, gelen para)
    const transaction_model.TransactionItem(
      id: 'tx_init_2',
      title: 'Zeynep Kaya',
      category: 'Maaş Ödemesi',
      date: 'Dün 16:45',
      amount: 8500.00,
      isExpense: false,//gelir bu sefer
      icon: Icons.account_balance_wallet_outlined,//cuzdan ikonu
    ),
  ];

  @override
  void dispose() {//sayfa kapaninca çalışır
    _ibanController.dispose();//controller i temizle
    _amountController.dispose();//bunu da temizle
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(//ana sayfa
      backgroundColor: const Color(0xFFF8FAFC),//renk değişr
      appBar: AppBar(//üstteki bar
        title: const Text(
          'Para Transferi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,//ortala
        backgroundColor: Colors.white,//renk değişr
        elevation: 0,//golge yok
      ),
      body: SingleChildScrollView(//kaydırılabilir yaptk
        physics: const BouncingScrollPhysics(),//zıplama efekti
        padding: const EdgeInsets.all(20),//her yerden 20
        child: Column(//alt alta diz
          crossAxisAlignment: CrossAxisAlignment.start,//sola yasla
          children: [
            _buildBalanceCard(),//bakiye kartı
            const SizedBox(height: 24),//busluk
            _buildHistoryHeader(),//başlık kısmı
            const SizedBox(height: 12),//busluk
            ..._history.map((tx) => _buildHistoryTile(tx)),//her işlem için satır yap
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(//sağ alttaki buton
        onPressed: _openTransferModal,//tıklayınca modal acılır
        backgroundColor: const Color(0xFF6366F1),//renk değişr
        foregroundColor: Colors.white,//renk değişr
        icon: const Icon(Icons.add),//artı ikonu
        label: const Text('Yeni Transfer'),
      ),
    );
  }

  // ============================================================
  // WIDGET: BAKİYE KARTI
  // ============================================================
  Widget _buildBalanceCard() {
    return Container(//kutu
      width: double.infinity,//tam genişlik
      padding: const EdgeInsets.all(20),//iç boşluk
      decoration: BoxDecoration(//süsleme
        gradient: const LinearGradient(//gradyan arka plan
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],//renk değişr
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),//köseler yuvarlak
        boxShadow: [//golge
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),//renk değişr
            blurRadius: 20,//bulanık
            offset: const Offset(0, 8),//aşağı kaydır
          ),
        ],
      ),
      child: Column(//alt alta
        crossAxisAlignment: CrossAxisAlignment.start,//sola yasla
        children: [
          Row(//yanyana
            children: const [
              Icon(Icons.account_balance_wallet,
                  color: Colors.white70, size: 18),//cuzdan ikonu
              SizedBox(width: 8),//busluk
              //bakiye yazısı
              Text(
                'Kullanılabilir Bakiye',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 10),//busluk
          //tutar yazısı
          Text(
            '₺ ${_balance.toStringAsFixed(2)}',//2 basamak goster
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WIDGET: GEÇMİŞ BAŞLIĞI
  // ============================================================
  Widget _buildHistoryHeader() {
    return Row(//yanyana
      mainAxisAlignment: MainAxisAlignment.spaceBetween,//iki uca dagıt
      children: [
        //başlık yazısı
        const Text(
          'Son İşlemler',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),//renk değişr
          ),
        ),
        //kaç işlem var yazısı
        Text(
          '${_history.length} işlem',//uzunluk kadar yaz
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),//renk değişr
        ),
      ],
    );
  }

  // ============================================================
  // WIDGET: İŞLEM SATIRI
  // ============================================================
  Widget _buildHistoryTile(transaction_model.TransactionItem tx) {
    final isExpense = tx.isExpense;//gider mi
    final amountColor =
        isExpense ? const Color(0xFFDC2626) : const Color(0xFF16A34A);//tutar rengi
    final iconBg =
        isExpense ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4);//ikon arka planı
    final iconColor =
        isExpense ? const Color(0xFFDC2626) : const Color(0xFF16A34A);//ikon rengi

    return Container(//işlem kutusu
      margin: const EdgeInsets.only(bottom: 10),//altta 10 bosluk
      padding: const EdgeInsets.all(12),//iç bosluk
      decoration: BoxDecoration(//süsleme
        color: Colors.white,//renk değişr
        borderRadius: BorderRadius.circular(14),//köse yuvarlak
        border: Border.all(color: const Color(0xFFE2E8F0)),//kenarlık
      ),
      child: Row(//yanyana
        children: [
          Container(//ikon kutusu
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,//renk değişr
              borderRadius: BorderRadius.circular(12),//köse yuvarlak
            ),
            child: Icon(tx.icon, color: iconColor, size: 20),//işlem ikonu
          ),
          const SizedBox(width: 12),//busluk
          Expanded(//kalan alanı kapla
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,//sola yasla
              children: [
                //işlem başlığı
                Text(
                  tx.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),//renk değişr
                  ),
                ),
                const SizedBox(height: 2),//busluk
                //kategori ve tarih
                Text(
                  '${tx.category} • ${tx.date}',//nokta ile birleştr
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),//renk değişr
                  ),
                ),
              ],
            ),
          ),
          //tutar yazısı
          Text(
            '${isExpense ? '-' : '+'}₺${tx.amount.toStringAsFixed(2)}',//işaret koy
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: amountColor,//renk değişr
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MODAL: TRANSFER FORMU
  // ============================================================
  void _openTransferModal() {//modal açar
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,//klavye acılınca yukarı kaysın
      backgroundColor: Colors.transparent,//saydam
      builder: (context) {
        return _buildTransferSheet();//form kısmını getir
      },
    );
  }

  Widget _buildTransferSheet() {
    return Padding(
      //klavye yüksekliğini hesapla
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(//form kutusu
        padding: const EdgeInsets.all(20),//iç bosluk
        decoration: const BoxDecoration(
          color: Colors.white,//renk değişr
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),//üst köseler yuvarlak
        ),
        child: Column(//alt alta
          mainAxisSize: MainAxisSize.min,//içeriğe gore boyut
          crossAxisAlignment: CrossAxisAlignment.start,//sola yasla
          children: [
            // ---- Tutma çubuğu
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),//renk değişr
                  borderRadius: BorderRadius.circular(2),//köse yuvarlak
                ),
              ),
            ),
            const SizedBox(height: 16),//busluk

            // ---- Başlık
            //form başlığı
            const Text(
              'Yeni Transfer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),//renk değişr
              ),
            ),
            const SizedBox(height: 4),
            //bakiye yazısı
            Text(
              'Bakiye: ₺ ${_balance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),//renk değişr
            ),
            const SizedBox(height: 20),

            // ---- IBAN Alanı
            _buildFieldLabel('Alıcı IBAN'),//etiket
            const SizedBox(height: 6),
            TextField(//iban girilen alan
              controller: _ibanController,
              keyboardType: TextInputType.text,//metin klavyesi
              textCapitalization: TextCapitalization.characters,//büyük harf
              decoration: _sheetInputDecoration('TR00 0000 ...'),//giriş süslemesi
            ),
            const SizedBox(height: 16),

            // ---- Tutar Alanı
            _buildFieldLabel('Tutar (₺)'),//etiket
            const SizedBox(height: 6),
            TextField(//tutar girilen alan
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),//ondalık sayı klavyesi
              decoration: _sheetInputDecoration('0,00'),//giriş süslemesi
            ),
            const SizedBox(height: 24),

            // ---- Onayla Butonu
            SizedBox(
              width: double.infinity,//tam genişlik
              height: 50,//yükseklik
              child: ElevatedButton(//onay butonu
                onPressed: _submitTransfer,//transfer yap
                style: ElevatedButton.styleFrom(//buton stili
                  backgroundColor: const Color(0xFF6366F1),//renk değişr
                  foregroundColor: Colors.white,//renk değişr
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),//köse yuvarlak
                  ),
                  elevation: 0,//golge yok
                ),
                //buton yazısı
                child: const Text(
                  'Transferi Onayla',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // YARDIMCI WIDGET'LAR
  // ============================================================
  Widget _buildFieldLabel(String text) {//etiket yazısı yapar
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF334155),//renk değişr
      ),
    );
  }

  InputDecoration _sheetInputDecoration(String hint) {//input süslemesi
    return InputDecoration(
      hintText: hint,//ipucu
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),//renk değişr
      filled: true,//arka plan dolu
      fillColor: const Color(0xFFF8FAFC),//renk değişr
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),//iç bosluk
      border: OutlineInputBorder(//normal kenarlık
        borderRadius: BorderRadius.circular(12),//köse yuvarlak
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),//renk değişr
      ),
      enabledBorder: OutlineInputBorder(//aktifken kenarlık
        borderRadius: BorderRadius.circular(12),//köse yuvarlak
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),//renk değişr
      ),
      focusedBorder: OutlineInputBorder(//odaklanınca kenarlık
        borderRadius: BorderRadius.circular(12),//köse yuvarlak
        borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),//renk değişr
      ),
    );
  }

  // ============================================================
  // TRANSFER GÖNDER
  // ============================================================
  void _submitTransfer() {//transferi yapar
    final iban = _ibanController.text.trim();//iban al boslukları sil
    final amountText = _amountController.text.trim().replaceAll(',', '.');//virgul noktaya cevir
    final amount = double.tryParse(amountText);//sayıya cevir

    // ---- Doğrulama
    if (iban.isEmpty || iban.length < 10) {//iban bos veya kısa
      _showSnackBar('Geçerli bir IBAN giriniz', isError: true);//hata goster
      return;//çık
    }
    if (amount == null || amount <= 0) {//tutar gecersiz
      _showSnackBar('Geçerli bir tutar giriniz', isError: true);//hata goster
      return;//çık
    }
    if (amount > _balance) {//bakiye yetmiyosa
      _showSnackBar('Yetersiz bakiye', isError: true);//hata goster
      return;//çık
    }

    // ---- Yeni işlem oluştur
    final newTx = transaction_model.TransactionItem(//yeni işlem yap
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',//benzersiz id
      title: iban.substring(0, 10) + '...',//ibanın ilk 10 karakteri
      category: 'Para Transferi',
      date: 'Şimdi',
      amount: amount,
      isExpense: true,//gider
      icon: Icons.send_rounded,//gonderme ikonu
    );

    // ---- State güncelle
    setState(() {//ekran yenilenir
      _balance -= amount;//bakiyeden dus
      _history.insert(0, newTx);//listeye başa ekle
    });

    // ---- Modal kapat, temizle, bilgi ver
    Navigator.pop(context);//modalı kapat
    _ibanController.clear();//iban temizle
    _amountController.clear();//tutar temizle
    _showSnackBar('₺${amount.toStringAsFixed(2)} transfer edildi ✅');//başarı mesajı
  }

  void _showSnackBar(String message, {bool isError = false}) {//alt bildirim goster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),//mesaj
        backgroundColor:
            isError ? const Color(0xFFDC2626) : const Color(0xFF16A34A),//renk değişr
        behavior: SnackBarBehavior.floating,//yüzen bildirim
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),//köse yuvarlak
        ),
      ),
    );
  }
}