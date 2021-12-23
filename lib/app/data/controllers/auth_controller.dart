import 'package:candella/app/data/models/result.dart';
import 'package:candella/app/data/models/success.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/auth_service.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService;

  static AuthController get to => Get.find();

  AuthController(this._authService);

  final formType = FormType.signIn.obs;
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController =
      TextEditingController(text: 'fscott@candella.com');
  late TextEditingController passwordController =
      TextEditingController(text: '404AdminPass');

  var obSecure = true.obs;
  var isLoading = false.obs;

  void setFormType(FormType formType) {
    this.formType.value = formType;
    update();
  }

  void setLoadingStatus(bool status) {
    isLoading.value = status;
    update();
  }

  Future<Result> loginUser() async {
    setLoadingStatus(true);
    var body = {
      "email": emailController.value.text,
      "password": passwordController.value.text
    };

    try {
      var response = await _authService.login(body);
      setLoadingStatus(false);
      if (response.hasError) {
        return Result(false, 'Login Failed. ${response.body?.message}');
      } else {
        final result = response.body;
        if (result is Success) {
          Prefs.saveToken(result.body);
          return Result(true, 'Login Successful');
        } else {
          return Result(false, 'An error has occurred. Try Again.');
        }
      }
    } catch (err) {
      return Result(false, err.toString());
    }
  }

  Future<Result> registerUser() async {
    setLoadingStatus(true);
    print('Register User');
    print(emailController.value);
    print(passwordController.value);

    String name = nameController.value.text;
    String email = emailController.value.text;
    String password = passwordController.value.text;

    var body = {"name": name, "email": email, "password": password};

    try {
      var response = await _authService.register(body);
      setLoadingStatus(false);
      if (response.hasError) {
        return Result(false, 'Registration Failed. ${response.body?.message}');
      }
      setFormType(FormType.signIn);
      return Result(true, '${response.body?.message}');
    } catch (err) {
      return Result(false, err.toString());
    }
  }
}
