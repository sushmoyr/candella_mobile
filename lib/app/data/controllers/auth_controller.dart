import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final formType = FormType.signUp.obs;
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  var obSecure = true.obs;
  var isLoading = false.obs;

  void setFormType(FormType formType) {
    this.formType.value = formType;
    update();
  }

  void loginUser() {
    print('Login');
    print(emailController.value.text);
    print(passwordController.value.text);
  }

  void registerUser() {
    print('Register User');
    print(emailController.value);
    print(passwordController.value);
  }
}
