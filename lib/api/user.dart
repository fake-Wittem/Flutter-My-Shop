// 封装用户相关api

// 登录接口
import 'package:my_shop/constants/index.dart';
import 'package:my_shop/utils/DioRequest.dart';
import 'package:my_shop/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.LOGIN, data: data),
  );
}
