class CategoryEntity {
  String categoryId;
  String name;
  int toalExpense;
  String icon;
  int color;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.toalExpense,
    required this.icon,
    required this.color,
  });

  Map<String, Object?> toDocument() {
    return {
      'categoryId': categoryId,
      'name': name,
      'toalExpense': toalExpense,
      'icon': icon,
      'color': color,
    };
  }

  static CategoryEntity fromDocument(Map<String, dynamic> document) {
    return CategoryEntity(
      categoryId: document['categoryId'] as String,
      name: document['name'] as String,
      toalExpense: document['toalExpense'] as int,
      icon: document['icon'] as String,
      color: document['color'] as int,
    );
  }
}
