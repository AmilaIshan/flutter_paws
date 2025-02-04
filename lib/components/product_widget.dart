import 'package:flutter/material.dart';
import 'package:paws/components/productDetailPage.dart';
import 'package:paws/models/product_entity.dart';
import 'package:paws/services/api_service.dart';

class ProductWidget extends StatelessWidget {
  final productEntity product;
  ProductWidget({super.key, required this.product });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product, apiService: ApiService(),),
            )
        );
      },
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 50,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'http://10.0.2.2:8000/storage/${product.imageUrl}',
                    height: 150,
                    width: 150,
                    errorBuilder: (context, error, stackTrace){
                      return Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey[200],
                        child: Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                  SizedBox(height: 5,),
                  Text(
                    product.productName,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("Rs: ${product.price}"),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async{
                          final apiService = ApiService();
                          try {
                            await apiService.addToCart(product.id, product.price, 1);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Product added to cart successfully!')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to add product to cart: $e')),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add to Cart"),
                            Icon(Icons.shopping_cart)
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          )
      ),

    );
  }
}