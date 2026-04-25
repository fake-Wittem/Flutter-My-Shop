import 'package:flutter/material.dart';
import 'package:my_shop/api/home.dart';
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
  // 轮播图列表
  List<BannerlItem> _bannerList = [];
  // 分类列表
  List<CategoryItem> _categoryItemList = [];
  // 特惠推荐
  SpecialOfferResult _specialOfferResult = SpecialOfferResult(
    id: '',
    title: '',
    subTypes: [],
  );
  // 热榜推荐
  SpecialOfferResult _inVogueResult = SpecialOfferResult(
    id: '',
    title: '',
    subTypes: [],
  );
  // 一站式推荐
  SpecialOfferResult _oneStopResult = SpecialOfferResult(
    id: '',
    title: '',
    subTypes: [],
  );

  // 整页所有的滚动子组件
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: Carousel(bannerList: _bannerList)), // 轮播图
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Category(categoryList: _categoryItemList),
      ), // 分类
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Recommend(specialOfferResult: _specialOfferResult),
      ), // 推荐
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: BestSelling(result: _inVogueResult, type: 'hot'),
              ), // 爆款推荐
              SizedBox(width: 10),
              Expanded(
                child: BestSelling(result: _oneStopResult, type: 'step'),
              ), //一站式买全
            ],
          ),
        ),
      ), // 爆款&一站式买全
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      ProductList(), // 无线滚动商品列表
    ];
  }

  // 获取轮播图
  void _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  // 获取分类列表
  void _getCategoryList() async {
    _categoryItemList = await getCategoryListAPI();
    setState(() {});
  }

  // 获取特惠推荐
  void _getSpecialOfferList() async {
    _specialOfferResult = await getSpecialOfferListAPI();
    setState(() {});
  }

  // 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getSpecialOfferList();
    _getInVogueList();
    _getOneStopList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
