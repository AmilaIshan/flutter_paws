import 'package:get/get.dart';
import 'package:paws/models/product_entity.dart';
import 'package:paws/services/api_service.dart';

class CategoryProductController extends GetxController{
  final ApiService _apiService = ApiService();
  final RxList<productEntity> categoryProducts = <productEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = "".obs;
  final int categoryId;

  CategoryProductController(this.categoryId);

  @override
  void onInit(){
    super.onInit();
    fetchCategoryProducts();
  }
  Future<void> fetchCategoryProducts() async{
    try{
      isLoading.value = true;
      error.value = "";
      final fetchedProducts = await _apiService.fetchCategoryProducts(categoryId);
      categoryProducts.assignAll(fetchedProducts);
    }catch (e){
      error.value = e.toString();
    }finally{
      isLoading.value = false;
    }
  }

}