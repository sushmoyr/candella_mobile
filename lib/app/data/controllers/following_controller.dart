import 'package:candella/app/data/models/follow_user.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:get/get.dart';

class FollowingController extends GetxController {
  final UserService _userService;

  FollowingController(this._userService);

  Rx<List<FollowUser>> following = Rx(<FollowUser>[]);

  void getFollowing(String id) async {
    var response = await _userService.getFollowing(id);

    if (!response.hasError) {
      List<FollowUser> data = response.body ?? [];
      data.printInfo();
      following(data);
      following.refresh();
    }
  }

  @override
  void onClose() {
    following.close();
    super.onClose();
  }
}
