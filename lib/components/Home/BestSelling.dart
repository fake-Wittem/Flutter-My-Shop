/* 爆款 */
import 'package:flutter/material.dart';
import 'package:my_shop/viewmodels/home.dart';

class BestSelling extends StatefulWidget {
  // 爆款推荐列表
  final SpecialOfferResult result;
  // 类型：爆款推荐/一站式买全
  final String type;
  const BestSelling({Key? key, required this.result, required this.type})
    : super(key: key);

  @override
  _BestSellingState createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  // 获取前两条数据(计算属性)
  List<GoodsItem> get _items {
    if (widget.result.subTypes.isEmpty) {
      return [];
    }
    return widget.result.subTypes.first.goodsItems.items.take(2).toList();
  }

  // 构建子项
  List<Widget> _getChildrenList() {
    return _items.map((item) {
      return Container(
        width: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.picture,
                width: 80,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'lib/assets/blank_image.png',
                    width: 80,
                    height: 100,
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            Text(
              "¥${item.price}",
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 86, 24, 20),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // 构建标题
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == 'step' ? '一站买全' : '爆款推荐',
          style: TextStyle(
            color: const Color.fromARGB(255, 86, 24, 20),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == 'step' ? '精心优选' : '最受欢迎',
          style: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(255, 124, 63, 58),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.type == 'step'
              ? const Color.fromARGB(255, 249, 247, 219)
              : const Color.fromARGB(255, 211, 228, 240),
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getChildrenList(),
            ),
          ],
        ),
      ),
    );
  }
}
