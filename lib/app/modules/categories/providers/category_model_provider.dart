import '../models/category_model_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryProviders extends GetConnect {
  Future<CategoryModel> getCategory() async {
    final response = await get(
        'https://themealdb.com/api/json/v1/1/filter.php?c=${Get.arguments}');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return CategoryModel.fromJson(response.body as Map<String, dynamic>);
    }
  }
}
