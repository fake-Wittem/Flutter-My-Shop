import 'package:flutter/material.dart';
import 'package:my_shop/components/Home/Carousel.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: Carousel()), // 轮播图
      SliverToBoxAdapter(child: SizedBox(height: 10)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
