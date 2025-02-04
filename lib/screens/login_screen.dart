import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paws/controllers/auth_controller.dart';
import 'package:paws/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter you email';
                    }
                    if(!GetUtils.isEmail(value)){
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder()
                  ),
                  obscureText: true,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please enter your password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                Obx( () {
                  if (_authController.error.isNotEmpty) {
                    return Text(
                      _authController.error.value,
                      style: TextStyle(color: Colors.red),
                    );
                  }return const SizedBox.shrink();
                }),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Obx(() {
                    if(_authController.isLoading.value){
                      return  Center(child: CircularProgressIndicator());
                    }else {
                      return ElevatedButton(
                          onPressed: () {
                            final authService = context.read<AuthService>();
                            if (_formKey.currentState!.validate()) {
                              _authController.login(
                                  _emailController.text,
                                  _passwordController.text,
                                authService
                              );
                              print('clicked');
                            }
                          },
                          child: const Text('Login')
                      );
                    }
                  }
                  ),
                ),
                const SizedBox(height: 16,),
                TextButton(
                    onPressed: () => Get.toNamed('/register'),
                    child: const Text('Don\'t have an account? Register')
                )
              ],
            )
        ),
      ),
    );
  }
}
