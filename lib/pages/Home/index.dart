import 'package:flutter/material.dart';
import 'package:my_shop/api/home.dart';
import 'package:my_shop/components/Home/BestSelling.dart';
import 'package:my_shop/components/Home/Carousel.dart';
import 'package:my_shop/components/Home/Category.dart';
import 'package:my_shop/components/Home/ProductList.dart';
import 'package:my_shop/components/Home/Recommend.dart';
import 'package:my_shop/utils/ToastUtils.dart';
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
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

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
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          color: const Color.fromARGB(255, 229, 229, 229),
          alignment: Alignment.center,
          child: Text(
            '推荐商品',
            style: TextStyle(
              fontSize: 11,
              color: const Color.fromARGB(255, 137, 137, 137),
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      ProductList(recommendList: _recommendList), // 无线滚动商品列表
    ];
  }

  // 获取轮播图
  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
  }

  // 获取分类列表
  Future<void> _getCategoryList() async {
    _categoryItemList = await getCategoryListAPI();
  }

  // 获取特惠推荐
  Future<void> _getSpecialOfferList() async {
    _specialOfferResult = await getSpecialOfferListAPI();
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  int _page = 1; // 页码
  bool _isLoading = false; // 当前正在加载下一页
  bool _hasMore = true; // 是否还有下一页
  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int requestLimit = _page * 10;
    _recommendList = await getRecommendListAPI({'limit': requestLimit});
    _isLoading = false;
    setState(() {});
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 注册滚动事件
  void _registerEvent() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 50)) {
        // 加载下一页
        _getRecommendList();
      }
    });
  }

  // 下拉刷新页面
  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialOfferList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    Toastutils.showToast(context, '刷新成功');
    _topPadding = 0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _registerEvent();
    // 微任务会在build周期完成后再执行
    Future.microtask(() {
      _topPadding = 100;
      setState(() {});
      _refreshKey.currentState?.show();
    });
  }

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();
  double _topPadding = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _topPadding),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
