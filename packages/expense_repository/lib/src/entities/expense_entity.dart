import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_repository/src/entities/category_entity.dart';

import '../models/category.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  int amount;
  DateTime date;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toDocument() {
    return {
      'expenseId': expenseId,
      'category': category.toEntity().toDocument(),
      'amount': amount,
      'date': date,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      expenseId: doc['expenseId'] as String,
      category:
          Category.fromEntity(CategoryEntity.fromDocument(doc['category'])),
      amount: doc['amount'] as int,
      date: (doc['date'] as Timestamp).toDate(),
    );
  }
}
