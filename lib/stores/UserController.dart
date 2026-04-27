import 'package:get/get.dart';
import 'package:my_shop/viewmodels/user.dart';

// 需要共享的对象
class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs; // user对象被监听(.obs)，取值用user.value

  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
