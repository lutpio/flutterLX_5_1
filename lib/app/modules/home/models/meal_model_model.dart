class MealModel {
  List<Meal>? meals;

  MealModel({this.meals});

  MealModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      meals = <Meal>[];
      json['categories'].forEach((v) {
        meals!.add(Meal.fromJson(v));
      });
    }
  }
}

class Meal {
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Meal({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  Meal.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryDescription = json['strCategoryDescription'];
    strCategoryThumb = json['strCategoryThumb'];
  }
}
