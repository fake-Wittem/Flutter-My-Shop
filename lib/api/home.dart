// 封装Home组件的api
import 'package:my_shop/constants/index.dart';
import 'package:my_shop/utils/DioRequest.dart';
import 'package:my_shop/viewmodels/home.dart';

// 获取轮播图
Future<List<BannerlItem>> getBannerListAPI() async {
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((
    item,
  ) {
    return BannerlItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

// 获取分类列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((
    item,
  ) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

// 获取特惠推荐
Future<SpecialOfferResult> getSpecialOfferListAPI() async {
  return SpecialOfferResult.formJSON(
    await dioRequest.get(HttpConstants.PRODUCT_LIST),
  );
}
