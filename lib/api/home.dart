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
  // 返回请求
  return SpecialOfferResult.formJSON(
    await dioRequest.get(HttpConstants.PRODUCT_LIST),
  );
}

// 热榜推荐
Future<SpecialOfferResult> getInVogueListAPI() async {
  // 返回请求
  return SpecialOfferResult.formJSON(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式买全
Future<SpecialOfferResult> getOneStopListAPI() async {
  // 返回请求
  return SpecialOfferResult.formJSON(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
