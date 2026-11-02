import 'package:flutter/material.dart';

class TransferFormScreen extends StatefulWidget {
  const TransferFormScreen({super.key});

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen> {
  // Formun genel anahtarı (Validation için gerekli)
  final _formKey = GlobalKey<FormState>();

  // TextField kontrolcüleri (Kullanıcının yazdığını okumak için)
  final _titleController = TextEditingController();
  final _genreController = TextEditingController();
  final _ratingController = TextEditingController();

  // Dropdown için seçili değer
  String _selectedStatus = 'İzleyeceğim';
  final List<String> _statusOptions = ['İzledim', 'İzleyeceğim', 'Yarıda Bıraktım'];

  @override
  void dispose() {
    // Bellek sızıntısını önlemek için kontrolcüleri temizle
    _titleController.dispose();
    _genreController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  // Formu kaydetme fonksiyonu
  void _saveMovie() {
    if (_formKey.currentState!.validate()) {
      // Form geçerliyse buradaki kod çalışır
      print("----- YENİ FİLM EKLENDİ -----");
      print("Film Adı: ${_titleController.text}");
      print("Tür: ${_genreController.text}");
      print("Puan: ${_ratingController.text}");
      print("Durum: $_selectedStatus");
      print("------------------------------");

      // Kullanıcıya başarılı olduğunu bildir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_titleController.text} arşivine eklendi!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Formu temizle
      _titleController.clear();
      _genreController.clear();
      _ratingController.clear();
      setState(() {
        _selectedStatus = 'İzleyeceğim';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yeni Film Ekle',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Başlık ---
              const Text(
                'Film Bilgilerini Girin',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Arşivine eklemek istediğin filmin detaylarını doldur.',
                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              ),
              const SizedBox(height: 30),

              // --- Film Adı ---
              _buildLabel('Film Adı'),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(
                  hint: 'Örn: Inception',
                  icon: Icons.movie_outlined,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen film adını girin';
                  }
                  if (value.length < 2) {
                    return 'Film adı en az 2 karakter olmalı';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // --- Tür ---
              _buildLabel('Tür'),
              TextFormField(
                controller: _genreController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(
                  hint: 'Örn: Bilim Kurgu / Aksiyon',
                  icon: Icons.category_outlined,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen film türünü girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // --- Puan ---
              _buildLabel('Puan (0-10)'),
              TextFormField(
                controller: _ratingController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(
                  hint: 'Örn: 8.5',
                  icon: Icons.star_outline,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen puan girin';
                  }
                  final rating = double.tryParse(value);
                  if (rating == null) {
                    return 'Geçerli bir sayı girin';
                  }
                  if (rating < 0 || rating > 10) {
                    return 'Puan 0 ile 10 arasında olmalı';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // --- İzlenme Durumu (Dropdown) ---
              _buildLabel('İzlenme Durumu'),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                dropdownColor: const Color(0xFF2C2C2C),
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(
                  hint: 'Durum seçin',
                  icon: Icons.check_circle_outline,
                ),
                items: _statusOptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 40),

              // --- Kaydet Butonu ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _saveMovie,
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    'Arşive Kaydet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Yardımcı Widget'lar (Kodu temiz tutmak için) ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white70,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint, required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[600]),
      prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
}