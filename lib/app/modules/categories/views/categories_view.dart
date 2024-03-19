import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:tugas5_1/app/modules/categories/models/category_model_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas5_1/app/routes/app_pages.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments),
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "List From API",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ).paddingOnly(bottom: 20),
          Flexible(
            child: FutureBuilder<CategoryModel>(
              future: controller.getCategory(),
              builder: (_, snapshot) {
                var data = snapshot.data?.categories;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 10,
                      crossAxisCount: 1,
                      childAspectRatio: .8,
                    ),
                    itemBuilder: (_, index) => itemCategories(data, index),
                    itemCount: data?.length,
                  );
                } else {
                  return const Center(
                    child: Text("Data Kosong"),
                  );
                }
              },
            ),
          )
        ]).paddingAll(10));
  }

  Container itemCategories(List<Category>? data, int index) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(10),
          ),
        ),
        child: Stack(children: <Widget>[
          new CachedNetworkImage(
            imageUrl: "${data?[index].strMealThumb}",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
              child: Text(
            data?[index].strMeal ?? "",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          )),
        ]));
  }
}
