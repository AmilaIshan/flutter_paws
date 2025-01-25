import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paws/components/product_widget.dart';
import 'package:paws/controllers/category_product_controller.dart';

class CategoryProducts extends StatelessWidget {
  final String categoryName;
  final int categoryId;
  CategoryProducts({super.key, required this.categoryName, required this.categoryId});



  @override
  Widget build(BuildContext context) {
    //final CategoryProductController productController = Get.find<CategoryProductController>();
    final CategoryProductController productController =
    Get.put(CategoryProductController(categoryId), tag: categoryId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Products'),
        backgroundColor: Colors.white,
      ),
      body: Obx((){
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (productController.error.isNotEmpty) {
          return Center(child: Text('Error: ${productController.error.value}'));
        }
        if (productController.categoryProducts.isEmpty) {
          return const Center(child: Text('No products found in this category'));
        }
        return GridView.builder(
          itemCount: productController.categoryProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.7,
          ),
          itemBuilder: (context, index) {
            final product = productController.categoryProducts[index];
            return ProductWidget(product: product); // A widget to display product info
          },
        );
      }),
    );
  }
}
