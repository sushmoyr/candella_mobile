import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  final UserService _userService;
  ProfileType profileType = ProfileType.self;

  ProfileScreenController(this._userService);
  var loading = RxBool(false);
  var user = Rx<User>(User());

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
  }

  void _saveCurrentUserToMemory(User user) {
    Prefs.saveUser(user.toRawJson());
  }
}
