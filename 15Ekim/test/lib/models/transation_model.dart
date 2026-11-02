//Icon data kullanmak için çağırılan kütüphane
import 'package:flutter/material.dart';

//TransactionItemlerinin tanımlaamalrı
class TransactionItem{
  final String id;
   final String title;
    final String category;
     final String date;
   final double amount;
   final bool isExpense;
   final IconData icon;

//required degerler başlangıçta girilmesi zorunlu degerlerdir
   const TransactionItem({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
    required this.isExpense,
    required this.icon,
   });

}
