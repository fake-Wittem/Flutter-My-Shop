// 封装Mine组件的api

import 'package:my_shop/constants/index.dart';
import 'package:my_shop/utils/DioRequest.dart';
import 'package:my_shop/viewmodels/home.dart';

// 猜你喜欢
Future<GoodsDetailItems> getUserLikeAPI(Map<String, dynamic> params) async {
  return GoodsDetailItems.formJSON(
    await dioRequest.get(HttpConstants.USER_LIKE_LIST, params: params),
  );
}
