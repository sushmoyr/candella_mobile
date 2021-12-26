import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/data/models/result.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:candella/app/services/file_service.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  final UserService _userService;
  ProfileType profileType = ProfileType.self;

  ProfileScreenController(this._userService);

  var loading = RxBool(false);
  var user = Rx<User>(User());
  var status = RxString('');
  var loadingAuthUpdate = RxBool(false);

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

  Future<Result> updateUser() async {
    loading(true);
    var _name = name.text;
    var _penName = penName.text;
    var _bio = bio.text;
    var _gender = gender.text;
    var _phone = phone.text;
    var _birthDate = birthdate.value!;
    var _address = address.text;

    Map<String, dynamic> requestBody = {
      "name": _name,
      "penName": _penName,
      "bio": _bio,
      "gender": _gender,
      "phone": _phone,
      "address": _address,
      "birthdate": _birthDate
    };

    if (profileImage.value != null) {
      try {
        var imageLink = await uploadPicture(profileImage.value);
        printInfo(info: imageLink);
        requestBody['profileImage'] = imageLink;
      } catch (e) {
        debugPrintStack(stackTrace: e as StackTrace);
      }
    }

    if (coverImage.value != null) {
      try {
        var imageLink = await uploadPicture(profileImage.value);
        requestBody['coverImage'] = imageLink;
      } catch (e) {
        debugPrintStack(stackTrace: e as StackTrace);
      }
    }

    status.value = 'Updating...';
    var response = await _userService.updateUser(requestBody);
    if (response.hasError) {
      return Result(false, response.statusText!);
    }

    if (response.body != null) {
      var updatedUser = response.body!;
      //Prefs.saveUser(updatedUser.toRawJson());
      //user.value = updatedUser;
      printInfo(info: "Updated Value = ${updatedUser.toRawJson()}");
    }

    Prefs.deleteUser();
    loadUser(null);

    return Result(true, 'Successfully Updated');
  }

  Future<String> uploadPicture(path) async {
    var fileService = Get.find<FileService>();

    var uploadedImageLink = await fileService.uploadImage(path, (value) {
      status.value = 'Uploading Image: $value%';
    });
    return uploadedImageLink;
  }

  Future<Result> updateSignInInfo() async {
    loadingAuthUpdate(true);

    var _email = email.text;
    var _password = oldPassword.text;
    var _newPassword = newPassword.text;

    Map<String, dynamic> requestBody = {
      "email": _email,
      "password": _password,
      "newPassword": _newPassword
    };

    var response = await _userService.updateAuthInfo(requestBody);

    loadingAuthUpdate(false);

    if (response.hasError) {
      return Result(false, response.statusText ?? 'Error! Try Again');
    }

    if (response.body != null) {
      var updatedUser = response.body!;
      printInfo(info: updatedUser.toRawJson());
    }
    Prefs.deleteUser();
    loadUser(null);

    return Result(true, 'Successfully Updated !!');
  }

  void _updateInputControllers() {
    name.text = user.value.name;
    email.text = user.value.email!;
    penName.text = user.value.penName ?? '';
    bio.text = user.value.bio ?? '';
    gender.text = user.value.gender;
    phone.text = user.value.phone ?? '';
    birthdate.value = user.value.birthdate;
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
