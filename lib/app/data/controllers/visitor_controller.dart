import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/data/models/result.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:get/get.dart';

class VisitorController extends GetxController {
  VisitorController(this._userService);

  final UserService _userService;
  final Rx<User> user = Rx(User());
  final RxBool isFollowedByMe = RxBool(false);
  final RxBool loading = RxBool(false);

  Future<Result> loadUser(String id) async {
    loading(true);
    //try {
    var response = await _userService.getUserFromId(id);
    loading(false);
    if (response.isOk) {
      printInfo(info: response.body!.toRawJson());
      user(response.body);
      _determineFollower(response.body!.followers);
      return Result(true, '');
    }
    return Result(false, '');
    /*} catch (e) {
      loading(false);
      e.printError();
      return Result(false, '');
    }*/
  }

  void _determineFollower(List<String> followers) {
    String currentUserRaw = Prefs.getCurrentUser()!;

    User currentUser = User.fromRawJson(currentUserRaw);

    String id = currentUser.id!;

    if (followers.contains(id)) {
      printInfo(info: 'I am following');
      isFollowedByMe(true);
    } else {
      isFollowedByMe(false);
    }
  }
}
