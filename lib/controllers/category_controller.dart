import 'package:get/get.dart';
import 'package:paws/models/category_entity.dart';
import 'package:paws/services/api_service.dart';

class CategoryController extends GetxController{
  final ApiService _apiService = ApiService();
  final RxList<CategoryEntity> categories = <CategoryEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = "".obs;

  @override
  void onInit(){
    super.onInit();
    fetchCategories();
  }
  Future<void> fetchCategories() async{
    try{
      isLoading.value = true;
      error.value = "";
      final fetchedCategories = await _apiService.fetchCategory();
      categories.assignAll(fetchedCategories);
    }catch (e){
      error.value = e.toString();
    }finally{
      isLoading.value = false;
    }
  }

}