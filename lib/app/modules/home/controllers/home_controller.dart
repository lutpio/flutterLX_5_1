import 'package:get/get.dart';
import 'package:tugas5_1/app/modules/home/models/meal_model_model.dart';
import 'package:tugas5_1/app/modules/home/providers/meal_model_provider.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  Future<MealModel> getMeal() async {
    final data = await MealProviders().getMeal();
    return data;
  }
}
