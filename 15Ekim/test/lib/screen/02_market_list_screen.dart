import 'package:flutter/material.dart';
import '../models/asset_model.dart';
import '../models/transation_model.dart';

class MarketsGridListScreen extends StatelessWidget {//extend widgetli class
  const MarketsGridListScreen({super.key});//super key

  // ============================================================
  // VARLIKLAR (Asset Listesi)
  // ============================================================
  static const List<Asset> assets = [//asste list tanımları
    Asset(
      symbol: 'BTC',
      name: 'Bitcoin',
      price: 67420.00,
      change24h: 4.20,
      balance: 0.4,
    ),
    Asset(
      symbol: 'ETH',
      name: 'Ethereum',
      price: 3500.00,
      change24h: -1.80,
      balance: 4.20,
    ),
    Asset(
      symbol: 'SOL',
      name: 'Solana',
      price: 200.00,
      change24h: 0.5,
      balance: 85.00,
    ),
  ];

  // ============================================================
  // İŞLEMLER (Transaction Listesi) - 4 ADET
  // ============================================================
  static const List<TransactionItem> transactions = [//işlem
    // 1. İşlem - Teknoloji
    TransactionItem(//tanım
      id: 'tx_1',
      title: 'Apple Store',
      category: 'Teknoloji',
      date: 'Bugün 14:20',
      amount: 64500.00,
      isExpense: true,
      icon: Icons.laptop_mac,
    ),

    // 2. İşlem - Kurumsal Gelir
    TransactionItem(//tanım
      id: 'tx_2',
      title: 'Kodusta Danışmanlık Hakediş',
      category: 'Kurumsal Gelir',
      date: 'Dün 09:00',
      amount: 125000.00,
      isExpense: false,
      icon: Icons.account_balance,
    ),

    // 3. İşlem (DEĞİŞTİRİLDİ) - Market
    TransactionItem(//tanım
      id: 'tx_3',
      title: 'Migros Alışveriş',
      category: 'Gıda & Market',
      date: 'Dün 18:45',
      amount: 1875.50,
      isExpense: true,
      icon: Icons.shopping_cart_outlined,
    ),

    // 4. İşlem (YENİ EKLENDİ) - Kahve
    TransactionItem(//tanım
      id: 'tx_4',
      title: 'Starbucks Coffee',
      category: 'Yemek & İçecek',
      date: 'Bugün 08:30',
      amount: 145.00,
      isExpense: true,
      icon: Icons.local_cafe_outlined,
    ),
  ];

  @override//ezme
  Widget build(BuildContext context) {
    return Scaffold(//iskelet
      backgroundColor: const Color(0xFFF8FAFC),//arkaplan renk
      appBar: AppBar(//appbar
        title: const Text(//title text işlemleri
          'Piyasalar & İşlemler',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,//ortalama
        backgroundColor: Colors.white,//renk
        elevation: 0,//gölge 0
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),//ıkon
            onPressed: () {},//tıklandığında
          ),
        ],
      ),
      body: SingleChildScrollView(//kaydırma
        physics: const BouncingScrollPhysics(),//fizik
        padding: const EdgeInsets.only(bottom: 32),//alttan 32 px iç boşluk
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,//soldan başlangıç
          children: [
            // ---- Piyasa Özeti Başlığı
            _buildSectionHeader(//header
              title: 'Piyasa Özeti',
              subtitle: '${assets.length} varlık',//asstes uzunluk
            ),

            // ---- Varlık Grid'i
            _buildAssetsGrid(),

            const SizedBox(height: 24),//boşluk 24px

            // ---- İşlemler Başlığı
            _buildSectionHeader(//işlemler başlığı
              title: 'Son İşlemler',
              subtitle: '${transactions.length} işlem',
            ),

            // ---- İşlem Listesi
            _buildTransactionsList(),//işlem list
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BÖLÜM BAŞLIĞI
  // ============================================================
  Widget _buildSectionHeader({//widget
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),//sol 20 üst 20 sağ 20 alt 12 px
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,//başlıklar arası boşluk
        children: [
          Text(//text işlemleri
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),//yatay 10 dikey 4 boşulk iç
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(20),//yuvarlama için 20 px
            ),
            child: Text(//text işlemleri
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6366F1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // VARLIK GRID'İ
  // ============================================================
  Widget _buildAssetsGrid() {//varlık gridi
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),//yatay 20px
      child: GridView.builder(//tembel grid
        shrinkWrap: true,//boyutu kısıtlar
        physics: const NeverScrollableScrollPhysics(),//fizik grid kaymayı kapatrır
        itemCount: assets.length,//asset uzuluğu
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(//grid düzenin belirler
          crossAxisCount: 2,//sütün sayısı 2
          crossAxisSpacing: 12,//sütün arası boşluk
          mainAxisSpacing: 12,//satır arası boşluk
          childAspectRatio: 1.15,//kartın genişlik yükselik oranı
        ),
        itemBuilder: (context, index) {
          return _buildAssetCard(assets[index]);//widget üretme
        },
      ),
    );
  }

  Widget _buildAssetCard(Asset asset) {
    final isPositive = asset.change24h >= 0;
    final changeColor =
        isPositive ? const Color(0xFF16A34A) : const Color(0xFFDC2626);
    final changeIcon =
        isPositive ? Icons.trending_up : Icons.trending_down;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(//boxshadow rendk saydamlık gölge işlemelr,
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sembol + Değişim Yüzdesi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  asset.symbol,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6366F1),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(changeIcon, color: changeColor, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    '${isPositive ? '+' : ''}${asset.change24h.toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: changeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // İsim
          Text(
            asset.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),

          // Fiyat
          Text(
            '\$${asset.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),

          // Bakiye
          Text(
            'Bakiye: ${asset.balance} ${asset.symbol}',
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // İŞLEM LİSTESİ
  // ============================================================
  Widget _buildTransactionsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: transactions.map((tx) {
          return _buildTransactionTile(tx);
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionTile(TransactionItem tx) {
    // Gider mi, gelir mi?
    final amountColor =
        tx.isExpense ? const Color(0xFFDC2626) : const Color(0xFF16A34A);
    final amountPrefix = tx.isExpense ? '-' : '+';
    final iconBgColor =
        tx.isExpense ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4);
    final iconColor =
        tx.isExpense ? const Color(0xFFDC2626) : const Color(0xFF16A34A);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),//alttan 10px dış
      padding: const EdgeInsets.all(12),//12px iç
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // İkon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(tx.icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),

          // Başlık + Kategori + Tarih
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,//soldan başlangıç
              children: [
                Text(
                  tx.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),//3px boşluk
                Row(
                  children: [
                    Container(//container işlemleri
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(//text işlemleri
                        tx.category,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),//boşluk
                    Flexible(
                      child: Text(//text işlmeleri
                        tx.date,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                        ),
                        overflow: TextOverflow.ellipsis,//uzun tariih keser
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),//8px boşluk

          // Tutar
          Text(
            '$amountPrefix₺${tx.amount.toStringAsFixed(2)}',//iki ondalık yazım
            style: TextStyle(//text işlemler,i
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}