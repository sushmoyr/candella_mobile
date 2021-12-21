import 'package:candella/app/data/controllers/profile_screen_controller.dart';
import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final String name = 'Home';
  late PageController featurePageController;
  late Rx<User> user = User().obs;
  final UserService _userService = Get.find();

  @override
  void onInit() async {
    featurePageController = PageController(initialPage: 0);

    user.value = await _loadCurrentUser();
    super.onInit();
  }

  Future<User> _loadCurrentUser() async {
    //loading(true);
    //First we will check if any user data has been saved before
    var userData = Prefs.getCurrentUser();
    //If userData is null means there is no user saved. hence we
    //will call api to get data.
    if (userData == null) {
      var token = Prefs.getToken();
      print('getting network data');
      var response = await _userService.getUserFromToken(token!);
      //loading(false);
      if (response.hasError) {
        print('User service error, ${response.statusText}');
        return Future.error(response.status);
      }

      var body = response.body;
      if (body != null) {
        //user(body);
        print(body.toRawJson());
        //then we will save the current user
        Prefs.saveUser(body.toRawJson());
        return body;
      } else {
        //User Not Found maybe error
        return Future.error('User not found');
      }

      //print((body == null) ? 'null body' : body.toRawJson());
    } else {
      //So user data is cached and we will show it.
      print('getting cached data');
      //loading(false);
      print(userData);
      return User.fromRawJson(userData);
      //user(User.fromRawJson(userData));
    }
  }
}
