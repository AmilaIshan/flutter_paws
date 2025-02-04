import 'package:flutter/material.dart';
import 'package:paws/models/product_entity.dart'; // Adjust import path as needed
import 'package:paws/services/api_service.dart'; // Import API service

class ProductDetailPage extends StatefulWidget {
  final productEntity product;
  final ApiService apiService; // Inject ApiService

  const ProductDetailPage({
    Key? key,
    required this.product,
    required this.apiService, // Pass ApiService
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isLoading = false;

  Future<void> _handleAddToCart() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.apiService.addToCart(
        5,  // Use the actual product ID
        850,
        1, // Default quantity to 1, you can modify this later
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added to cart successfully!')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productName),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'http://10.0.2.2:8000/storage/${widget.product.imageUrl}', // Update base URL as needed
                height: 300,
                width: 300,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    width: 300,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, size: 100),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: Rs ${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Quantity Available: ${widget.product.quantity}',
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.product.quantity > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  if (widget.product.weight != null)
                    Text(
                      'Weight: ${widget.product.weight}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: widget.product.quantity > 0
                          ? _isLoading
                          ? null
                          : _handleAddToCart
                          : null,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Add to Cart'),
                          SizedBox(width: 10),
                          Icon(Icons.shopping_cart),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
