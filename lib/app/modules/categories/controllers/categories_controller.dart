import 'package:get/get.dart';
import 'package:tugas5_1/app/modules/categories/models/category_model_model.dart';
import 'package:tugas5_1/app/modules/categories/providers/category_model_provider.dart';

class CategoriesController extends GetxController {
  //TODO: Implement CategoriesController

  Future<CategoryModel> getCategory() async {
    final data = await CategoryProviders().getCategory();
    return data;
  }
}
