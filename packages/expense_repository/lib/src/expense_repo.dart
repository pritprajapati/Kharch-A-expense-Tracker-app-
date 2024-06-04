import 'package:expenses_repository/src/models/category.dart';

import 'models/expense.dart';

abstract class ExpenseRepository {
  Future<void> createCategory(Category category);
  Future<List<Category>> getCategory();
  Future<void> createExpense(Expense expense);
  Future<List<Expense>> getExpense();
}
