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
