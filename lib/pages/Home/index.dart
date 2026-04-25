import 'package:flutter/material.dart';
import 'package:my_shop/components/Home/BestSelling.dart';
import 'package:my_shop/components/Home/Carousel.dart';
import 'package:my_shop/components/Home/Category.dart';
import 'package:my_shop/components/Home/ProductList.dart';
import 'package:my_shop/components/Home/Recommend.dart';
import 'package:my_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BannerlItem> _bannerList = [
    BannerlItem(
      id: '1',
      imgUrl: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg',
    ),
    BannerlItem(
      id: '2',
      imgUrl: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.jpg',
    ),
    BannerlItem(
      id: '3',
      imgUrl: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg',
    ),
  ];

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: Carousel(bannerList: _bannerList)), // 轮播图
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: Category()), // 分类
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: Recommend()), // 推荐
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: BestSelling()),
              SizedBox(width: 10),
              Expanded(child: BestSelling()),
            ],
          ),
        ),
      ), // 爆款
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      ProductList(), // 无线滚动商品列表
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
