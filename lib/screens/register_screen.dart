import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paws/controllers/auth_controller.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final AuthController _authController = AuthController();
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
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter you name';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16),
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
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder()
                  ),
                  obscureText: true,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please confirm your password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Obx(() {
                    if(_authController.isLoading.value){
                      return  Center(child: CircularProgressIndicator());
                    }else {
                      return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _authController.register(
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  _confirmPasswordController.text
                              );
                              print('clicked');
                            }
                          },
                          child: const Text('Register')
                      );
                    }
                  }
                  ),
                ),
                const SizedBox(height: 16,),
                TextButton(
                    onPressed: () => Get.toNamed('/login'),
                    child: const Text('Have an account ? Login')
                )
              ],
            )
        ),
      ),
    );
  }
}
