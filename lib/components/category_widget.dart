import 'package:flutter/material.dart';
import 'package:paws/components/category_products.dart';

class CategoryWidget extends StatelessWidget {
  final String label;
  final String image;
  final int id;
  const CategoryWidget({super.key, required this.label, required this.image, required this.id});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProducts(
              categoryId: id,
              categoryName: label,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.orangeAccent[50],
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage('http://10.0.2.2:8000/storage/$image'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8,),
            Text(label)
          ],
        ),
      ),
    );
  }
}
