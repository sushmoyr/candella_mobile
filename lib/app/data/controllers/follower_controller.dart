import 'package:candella/app/data/models/follow_user.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:get/get.dart';

class FollowerController extends GetxController {
  final UserService _userService;

  FollowerController(this._userService);

  Rx<List<FollowUser>> followers = Rx(<FollowUser>[]);

  void getFollowers(String id) async {
    var response = await _userService.getFollower(id);

    if (!response.hasError) {
      List<FollowUser> data = response.body ?? [];
      data.printInfo();
      followers(data);
      followers.refresh();
    }
  }

  @override
  void onClose() {
    followers.close();
    super.onClose();
  }
}
