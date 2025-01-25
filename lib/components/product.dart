import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paws/components/product_widget.dart';
import 'package:paws/controllers/product_controller.dart';

class Product extends StatelessWidget {
  final ProductController _productController = Get.put(ProductController());
  Product({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(_productController.isLoading.value){
        return Center(child: CircularProgressIndicator(),);
      }
      if(_productController.error.isNotEmpty){
        return Center(child: Text("Error: ${_productController.error.value}"),);
      }
      return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _productController.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1/1.7
          ),
          itemBuilder: (context, index) {
            final product = _productController.products[index];
            return ProductWidget(product: product);
          }
      );
    });
  }
}
