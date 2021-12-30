import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/data/models/result.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:get/get.dart';

class VisitorController extends GetxController {
  VisitorController(this._userService);

  final UserService _userService;
  final Rx<User> user = Rx(User());
  final RxBool loading = RxBool(false);

  Future<Result> loadUser(String id) async {
    loading(true);
    //try {
    var response = await _userService.getUserFromId(id);
    loading(false);
    if (response.isOk) {
      printInfo(info: response.body!.toRawJson());
      user(response.body);
      return Result(true, '');
    }
    return Result(false, '');
    /*} catch (e) {
      loading(false);
      e.printError();
      return Result(false, '');
    }*/
  }
}
