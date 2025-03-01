import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:paws/models/category_entity.dart';
import 'package:paws/models/product_entity.dart';
import 'dart:convert';

import 'package:paws/models/user.dart';
import 'package:paws/services/auth_service.dart';

class ApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // final String baseUrl = 'http://192.168.1.2:8000/api';
  final String baseUrl = 'http://10.0.2.2:8000/api';
  Map<String, String> get _headers => {
    'Accept': 'application/json',
    'Content-type' : 'application/json',
    'X-Requested-With': 'XMLHttpRequest'
  };

  Future<Map<String, String>> _getHeaders() async{
    final headers = Map<String, String>.from(_headers);
    final token = await _storage.read(key: 'token');
    if(token != null){
      final bearerToken = token.startsWith('Bearer') ? token : 'Bearer $token';
      headers['Authorization'] = bearerToken;
      print("Token $bearerToken");
    }else{
      print("Token null");
    }
    return headers;
  }

  Future<String?> _getCsrfToken() async {
    try{
      final response = await http.get(
        Uri.parse('$baseUrl/sanctum/csrf-cookie'),
        headers: _headers,
      );
      print("CSRF Response status : ${response.statusCode}");
      print("CSRF Response Headers: ${response.headers}");

      final cookies = response.headers['set-cookie'];
      if(cookies != null){
        final xsrfToken = cookies.split(':').firstWhere(
              (cookie) => cookie.trim().startsWith('XSRF-TOKEN='),
          orElse: () => '',
        );
        if(xsrfToken.isNotEmpty){
          return Uri.decodeComponent(xsrfToken.split('=')[1]);
        }
      }
    }catch(e){
      print('Error fetching CSRF token: $e');
    }
    return null;
  }

  Future<User> register(String name, String email, String password, String passwordConfirmation) async{
    try{
      final headers = await _getHeaders();
      final csrfToken = await _getCsrfToken();
      if(csrfToken != null){
        headers['X-XSRF-TOKEN'] = csrfToken;
      }
      final response = await http.post(
          Uri.parse('$baseUrl/register'),
          headers: headers,
          body: jsonEncode({
            'name' : name,
            'email': email,
            'password': password,
            'password_confirmation': passwordConfirmation,
          })
      );
      if(response.statusCode == 200 || response.statusCode == 201 ){
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        user.token = data['token'];
        await _storage.write(key: 'token', value: user.token);
        return user;
      }else{
        throw _handleError(response);
      }
    }catch(e){
      print('Error registering user: $e');
      throw _handleError(e);
    }
  }

  Future<User> login(String email, String password, AuthService authService) async{
    try{
      final headers = await _getHeaders();
      final csrfToken = await _getCsrfToken();
      if(csrfToken != null){
        headers['X-XSRF-TOKEN'] = csrfToken;
      }
      final response = await http.post(
          Uri.parse('$baseUrl/login'),
          headers: headers,
          body: jsonEncode({
            'email': email,
            'password': password,
          })
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        user.token = data['token'].toString();

          authService.setUserName(data['user']['name']);
        print("username");
        print(data['user']['name']);
        await _storage.write(key: 'token', value: user.token);
        return user;
      }else{
        throw _handleError(response);
      }
    }catch(e){
      print('Error logging user: $e');
      throw _handleError(e);
    }
  }

  Future<List<CategoryEntity>> fetchCategory() async{
    final url = Uri.parse('$baseUrl/category');
    final header = await _getHeaders();
    final csrfToken = await _getCsrfToken();
    if(csrfToken != null){
      header['X-XSRF-TOKEN'] = csrfToken;
    }

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200){
      final decodedResponse =jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];
      return data.map((json) => CategoryEntity.fromJson(json)).toList();
    }else{
      throw _handleError(response);
    }
  }

  Future<List<productEntity>> fetchProduct() async{
    final url = Uri.parse('$baseUrl/products');
    final header = await _getHeaders();
    final csrfToken = await _getCsrfToken();
    if(csrfToken != null){
      header['X-XSRF-TOKEN'] = csrfToken;
    }

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200){
      final decodedResponse = jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];
      return data.map((json) => productEntity.fromJson(json)).toList();
    }else{
      throw _handleError(response);
    }
  }

  Future<List<productEntity>> fetchCategoryProducts(int categoryId) async{
    final url = Uri.parse('$baseUrl/category/$categoryId');
    final header = await _getHeaders();
    final csrfToken = await _getCsrfToken();
    if(csrfToken != null){
      header['X-XSRF-TOKEN'] = csrfToken;
    }

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200){
      final decodedResponse = jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];
      return data.map((json) => productEntity.fromJson(json)).toList();
    }else{
      throw _handleError(response);
    }
  }

  Future<void> addToCart(int productId, int price, int quantity) async {
    try {
      final headers = await _getHeaders();
      final csrfToken = await _getCsrfToken();
      if (csrfToken != null) {
        headers['X-XSRF-TOKEN'] = csrfToken;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/cart'),
        headers: headers,
        body: jsonEncode({
          'product_id': productId,
          'price': price,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Product added to cart successfully!');
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      print('Error adding product to cart: $e');
      throw _handleError(e);
    }
  }




  String _handleError(dynamic error){
    if(error is http.Response){
      print("Error Response Status: ${error.statusCode}");
      print("Error Response Headers: ${error.headers}");
      print("Error Response Body: ${error.body}");
      try{
        final data = jsonDecode(error.body);
        return data['message'] ?? 'Something went wrong';
      }catch(_){
        return 'Something went wrong';
      }
    }
    return error.toString();
  }
}