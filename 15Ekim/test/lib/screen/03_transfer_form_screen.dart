import 'package:flutter/material.dart';
import '../models/transation_model.dart' as transaction_model;

class TransferFormScreen extends StatefulWidget {
  const TransferFormScreen({super.key});

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen> {
  // ============================================================
  // STATE
  // ============================================================
  double _balance = 149950.00;

  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<transaction_model.TransactionItem> _history = [
    // ---- 1. İŞLEM (Gelen Transfer)
    const transaction_model.TransactionItem(
      id: 'tx_init_1',
      title: 'Ahmet Yılmaz',
      category: 'Hızlı Transfer',
      date: 'Bugün 11:30',
      amount: 1500.00,
      isExpense: true,
      icon: Icons.send_rounded,
    ),

    // ---- 2. İŞLEM (DÜZENLENDİ - Farklı alıcı, gelen para)
    const transaction_model.TransactionItem(
      id: 'tx_init_2',
      title: 'Zeynep Kaya',
      category: 'Maaş Ödemesi',
      date: 'Dün 16:45',
      amount: 8500.00,
      isExpense: false,
      icon: Icons.account_balance_wallet_outlined,
    ),
  ];

  @override
  void dispose() {
    _ibanController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Para Transferi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 24),
            _buildHistoryHeader(),
            const SizedBox(height: 12),
            ..._history.map((tx) => _buildHistoryTile(tx)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openTransferModal,
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Yeni Transfer'),
      ),
    );
  }

  // ============================================================
  // WIDGET: BAKİYE KARTI
  // ============================================================
  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.account_balance_wallet,
                  color: Colors.white70, size: 18),
              SizedBox(width: 8),
              Text(
                'Kullanılabilir Bakiye',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '₺ ${_balance.toStringAsFixed(2)}',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Son İşlemler',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        Text(
          '${_history.length} işlem',
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
      ],
    );
  }

  // ============================================================
  // WIDGET: İŞLEM SATIRI
  // ============================================================
  Widget _buildHistoryTile(transaction_model.TransactionItem tx) {
    final isExpense = tx.isExpense;
    final amountColor =
        isExpense ? const Color(0xFFDC2626) : const Color(0xFF16A34A);
    final iconBg =
        isExpense ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4);
    final iconColor =
        isExpense ? const Color(0xFFDC2626) : const Color(0xFF16A34A);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(tx.icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${tx.category} • ${tx.date}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isExpense ? '-' : '+'}₺${tx.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MODAL: TRANSFER FORMU
  // ============================================================
  void _openTransferModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Klavye açılınca modal yukarı kaysın
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _buildTransferSheet();
      },
    );
  }

  Widget _buildTransferSheet() {
    return Padding(
      // Klavye yüksekliğini hesaba kat
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Tutma çubuğu
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ---- Başlık
            const Text(
              'Yeni Transfer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Bakiye: ₺ ${_balance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            // ---- IBAN Alanı
            _buildFieldLabel('Alıcı IBAN'),
            const SizedBox(height: 6),
            TextField(
              controller: _ibanController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              decoration: _sheetInputDecoration('TR00 0000 ...'),
            ),
            const SizedBox(height: 16),

            // ---- Tutar Alanı
            _buildFieldLabel('Tutar (₺)'),
            const SizedBox(height: 6),
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: _sheetInputDecoration('0,00'),
            ),
            const SizedBox(height: 24),

            // ---- Onayla Butonu
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitTransfer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
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
  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF334155),
      ),
    );
  }

  InputDecoration _sheetInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
      ),
    );
  }

  // ============================================================
  // TRANSFER GÖNDER
  // ============================================================
  void _submitTransfer() {
    final iban = _ibanController.text.trim();
    final amountText = _amountController.text.trim().replaceAll(',', '.');
    final amount = double.tryParse(amountText);

    // ---- Doğrulama
    if (iban.isEmpty || iban.length < 10) {
      _showSnackBar('Geçerli bir IBAN giriniz', isError: true);
      return;
    }
    if (amount == null || amount <= 0) {
      _showSnackBar('Geçerli bir tutar giriniz', isError: true);
      return;
    }
    if (amount > _balance) {
      _showSnackBar('Yetersiz bakiye', isError: true);
      return;
    }

    // ---- Yeni işlem oluştur
    final newTx = transaction_model.TransactionItem(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      title: iban.substring(0, 10) + '...',
      category: 'Para Transferi',
      date: 'Şimdi',
      amount: amount,
      isExpense: true,
      icon: Icons.send_rounded,
    );

    // ---- State güncelle
    setState(() {
      _balance -= amount;
      _history.insert(0, newTx);
    });

    // ---- Modal kapat, temizle, bilgi ver
    Navigator.pop(context);
    _ibanController.clear();
    _amountController.clear();
    _showSnackBar('₺${amount.toStringAsFixed(2)} transfer edildi ✅');
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? const Color(0xFFDC2626) : const Color(0xFF16A34A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}