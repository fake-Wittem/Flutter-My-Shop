/* 商品列表 */
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      // 2列网格
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10, // 主轴间隙
        crossAxisSpacing: 10, // 交叉轴间隙
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text('商品', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}
