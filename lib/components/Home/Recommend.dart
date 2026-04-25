/* 推荐 */
import 'package:flutter/material.dart';
import 'package:my_shop/viewmodels/home.dart';

class Recommend extends StatefulWidget {
  // 特惠推荐
  final SpecialOfferResult specialOfferResult;
  const Recommend({Key? key, required this.specialOfferResult})
    : super(key: key);

  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  // 取前3条推荐商品
  List<GoodsItem> _getDisplayGoods() {
    if (widget.specialOfferResult.subTypes.isEmpty) return [];
    return widget.specialOfferResult.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  // 生成顶部标题
  Widget _buildHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        'lib/assets/home_cmd_title.png',
        width: 140,
        height: 20,
        fit: BoxFit.fill,
      ),
    );
  }

  // 生成左侧广告
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('lib/assets/home_cmd_inner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 生成前3条推荐商品
  List<Widget> _getGoodList() {
    List<GoodsItem> list = _getDisplayGoods();
    return List.generate(list.length, (int index) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) {
                // 图片构建失败时，占空
                return Image.asset(
                  'lib/assets/blank_image.png',
                  width: 100,
                  height: 140,
                  fit: BoxFit.cover,
                );
              },
              list[index].picture,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 255, 73, 7),
            ),
            child: Text(
              '￥${list[index].price}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        // height: 300,
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage('lib/assets/home_cmd_sm.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            // 中心内容
            Row(
              children: [
                _buildLeft(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getGoodList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
