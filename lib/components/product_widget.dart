import 'package:flutter/material.dart';
import 'package:paws/components/productDetailPage.dart';
import 'package:paws/models/product_entity.dart';

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
              builder: (context) => ProductDetailPage(product: product),
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
                color: Colors.orangeAccent[100]
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'https://www.petexpress.com.ph/cdn/shop/files/10178527-Whiskas-Junior-Mackerel-Wet-Cat-Food-80g-_14-pouches_-FRONT.jpg?v=1701663024',
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
                        onPressed: (){
                          print("Add to Cart Clicked");
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