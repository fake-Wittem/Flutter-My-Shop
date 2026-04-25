// 每个轮播图的类型
class BannerlItem {
  String id;
  String imgUrl;
  BannerlItem({required this.id, required this.imgUrl});
  // 请求返回值处理
  factory BannerlItem.formJSON(Map<String, dynamic> json) {
    return BannerlItem(id: json['id'] ?? '', imgUrl: json['imgUrl'] ?? '');
  }
}

// 每个分类的类型
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  // 请求返回值处理
  factory CategoryItem.formJSON(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      children: json['children'] == null
          ? null
          : (json['children'] as List)
                .map(
                  (item) => CategoryItem.formJSON(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

// 特惠推荐商品项
class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.formJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'],
      price: json['price'] ?? '',
      picture: json['picture'] ?? '',
      orderNum: json['orderNum'] ?? 0,
    );
  }
}

// 商品列表
class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.formJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items: (json['items'] as List)
          .map((item) => GoodsItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

// 子类型
class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});
  factory SubType.formJSON(Map<String, dynamic> json) {
    return SubType(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodsItems: GoodsItems.formJSON(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }
}

// 特惠推荐结果
class SpecialOfferResult {
  String id;
  String title;
  List<SubType> subTypes;
  SpecialOfferResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory SpecialOfferResult.formJSON(Map<String, dynamic> json) {
    return SpecialOfferResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTypes: (json['subTypes'] as List)
          .map((item) => SubType.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
