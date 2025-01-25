import 'package:get/get.dart';
import 'package:paws/models/product_entity.dart';
import 'package:paws/services/api_service.dart';

class ProductController extends GetxController{
  final ApiService _apiService = ApiService();
  final RxList<productEntity> products = <productEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = "".obs;

  @override
  void onInit(){
    super.onInit();
    fetchProducts();
  }
  Future<void> fetchProducts() async{
    try{
      isLoading.value = true;
      error.value = "";
      final fetchedProducts = await _apiService.fetchProduct();
      products.assignAll(fetchedProducts);
    }catch (e){
      error.value = e.toString();
    }finally{
      isLoading.value = false;
    }
  }

}