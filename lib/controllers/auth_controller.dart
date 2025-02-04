import 'package:get/get.dart';
import 'package:paws/models/user.dart';
import 'package:paws/services/api_service.dart';
import 'package:paws/services/auth_service.dart';


class AuthController extends GetxController{
  final ApiService _apiService = ApiService();
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = "".obs;

  bool get isLoggedIn => _currentUser.value != null;

  Future<void> register(String name, String email, String password, String passwordConfirmation) async{
    try{
      isLoading.value = true;
      error.value = "";
      final newUser = await _apiService.register(name, email, password, passwordConfirmation);
      _currentUser.value = newUser;
      Get.offAllNamed('/navigation');
    } catch(e){
      error.value = e.toString();
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password, AuthService authService) async{
    try{
      isLoading.value = true;
      error.value = "";
      final newUser = await _apiService.login(email, password, authService);
      _currentUser.value = newUser;
      Get.offAllNamed('/navigation');
    } catch(e){
      error.value = e.toString();
    }finally{
      isLoading.value = false;
    }
  }
}