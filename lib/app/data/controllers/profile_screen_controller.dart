import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  final UserService _userService;
  ProfileType profileType = ProfileType.self;

  ProfileScreenController(this._userService);

  var loading = RxBool(false);
  var user = Rx<User>(User());

  //edit page data
  final Rx<String?> coverImage = Rx(null);
  final Rx<String?> profileImage = Rx(null);
  final name = TextEditingController();
  final email = TextEditingController();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final penName = TextEditingController();
  final bio = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final gender = TextEditingController();
  Rx<String?> birthdate = Rx(null);

  void loadUser(String? id) async {
    loading(true);
    if (id == null) {
      profileType = ProfileType.self;
      //Id null so it is taking current user
      //First we will check if any user data has been saved before
      var userData = Prefs.getCurrentUser();
      //If userData is null means there is no user saved. hence we
      //will call api to get data.
      if (userData == null) {
        var token = Prefs.getToken();
        print('getting network data');
        var response = await _userService.getUserFromToken(token!);
        loading(false);
        if (response.hasError) {
          print('User service error, ${response.statusText}');
          return;
        }

        var body = response.body;
        if (body != null) {
          user(body);
          print(body);
          //then we will save the current user
          _saveCurrentUserToMemory(body);
        } else {
          //unknown error
          //TODO handle unknown error
        }

        //print((body == null) ? 'null body' : body.toRawJson());
      } else {
        //So user data is cached and we will show it.
        print('getting cached data');
        loading(false);
        print(userData);
        user(User.fromRawJson(userData));
      }
    } else {
      profileType = ProfileType.other;
      _userService.getUserFromId(id);
    }

    _updateInputControllers();
  }

  void updateUser() async {}

  void _updateInputControllers() {
    name.text = user.value.name;
    email.text = user.value.email!;
    penName.text = user.value.penName ?? '';
    bio.text = user.value.bio ?? '';
    phone.text = user.value.phone ?? '';
    address.text = user.value.address ?? '';
  }

  DateTime getBirthDate() {
    String date = birthdate.value ?? user.value.birthdate;
    var dateArray = date.split('/');
    print(dateArray);
    return DateTime(
      int.parse(dateArray[2]),
      int.parse(dateArray[1]),
      int.parse(dateArray[0]),
    );
  }

  void _saveCurrentUserToMemory(User user) {
    Prefs.saveUser(user.toRawJson());
  }
}
