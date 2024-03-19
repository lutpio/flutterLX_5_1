import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tugas5_1/app/routes/app_pages.dart';
import '../models/meal_model_model.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 18,
                        color: Colors.grey[500],
                      ),
                      const Text(
                        "Search",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ).paddingAll(10),
                ),
              ).paddingSymmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "List Meal From API",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ).paddingOnly(bottom: 20),
          Flexible(
            child: FutureBuilder<MealModel>(
              future: controller.getMeal(),
              builder: (_, snapshot) {
                var data = snapshot.data?.meals;
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
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: .8,
                    ),
                    itemBuilder: (_, index) => itemRestaurant(data, index),
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

  Container itemRestaurant(List<Meal>? data, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(10),
        ),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                ScreenUtil().setWidth(10),
              ),
              topRight: Radius.circular(
                ScreenUtil().setWidth(10),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: "${data?[index].strCategoryThumb}",
              height: 135,
              width: 200,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    child: GestureDetector(
                  onTap: () async {
                    await Get.toNamed(Routes.CATEGORIES,
                        arguments: data?[index].strCategory ?? "");
                    // print("Button Clicked");
                  },
                  child: Text(
                    data?[index].strCategory ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                const Spacer(),
              ],
            ).paddingOnly(
              top: 10,
              left: 10,
              right: 10,
            ),
          ),
          Flexible(
              child: GestureDetector(
            onTap: () async {
              await Get.toNamed(Routes.CATEGORIES,
                  arguments: data?[index].strCategory ?? "");
              // print("Button Clicked");
            },
            child: Text(
              data?[index].strCategoryDescription ?? "",
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w300,
              ),
            ).paddingOnly(
              left: 10,
              right: 10,
            ),
          )),
        ],
      ),
    );
  }
}
