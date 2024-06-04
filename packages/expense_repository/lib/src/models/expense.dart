import 'package:expenses_repository/src/entities/expense_entity.dart';
import 'package:expenses_repository/src/models/category.dart';

class Expense {
  String expenseId;
  Category category;
  int amount;
  DateTime date;

  Expense({
    required this.expenseId,
    required this.category,
    required this.amount,
    required this.date,
  });

  static final empty = Expense(
    expenseId: '',
    category: Category.empty,
    amount: 0,
    date: DateTime.now(),
  );

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId: expenseId,
      category: category,
      amount: amount,
      date: date,
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      expenseId: entity.expenseId,
      category: entity.category,
      amount: entity.amount,
      date: entity.date,
    );
  }
}
