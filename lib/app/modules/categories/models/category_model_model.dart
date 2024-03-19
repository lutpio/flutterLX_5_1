class CategoryModel {
  List<Category>? categories;

  CategoryModel({this.categories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      categories = <Category>[];
      json['meals'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }
}

class Category {
  String? strMeal;
  String? strMealThumb;

  Category({
    this.strMeal,
    this.strMealThumb,
  });

  Category.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
  }
}
