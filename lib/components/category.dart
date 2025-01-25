import 'package:flutter/material.dart';
import 'package:paws/components/category_widget.dart';
import 'package:paws/controllers/category_controller.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {
  final CategoryController _categoryController = Get.put(CategoryController());
  Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(_categoryController.isLoading.value){
        return Center(child: CircularProgressIndicator(),);
      }
      if(_categoryController.error.isNotEmpty){
        return Center(child: Text("Error: ${_categoryController.error.value}"),);
      }
      return ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: _categoryController.categories.length,
          itemBuilder: (context, index){
            final category = _categoryController.categories[index];
            return CategoryWidget(
                label: category.label,
                image: category.image,
                id: category.id,
            );
          }
      );
    });
  }
}
