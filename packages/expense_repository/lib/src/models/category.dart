import 'package:expenses_repository/src/entities/category_entity.dart';

class Category {
  String categoryId;
  String name;
  int toalExpense;
  String icon;
  int color;

  Category({
    required this.categoryId,
    required this.name,
    required this.toalExpense,
    required this.icon,
    required this.color,
  });

  static final empty = Category(
    categoryId: '',
    name: '',
    toalExpense: 0,
    icon: '',
    color: 0,
  );

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      toalExpense: toalExpense,
      icon: icon,
      color: color,
    );
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      categoryId: entity.categoryId,
      name: entity.name,
      toalExpense: entity.toalExpense,
      icon: entity.icon,
      color: entity.color,
    );
  }
}
