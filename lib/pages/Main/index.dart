import 'package:flutter/material.dart';
import 'package:my_shop/pages/Cart/index.dart';
import 'package:my_shop/pages/Category/index.dart';
import 'package:my_shop/pages/Home/index.dart';
import 'package:my_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义导航数据，用于渲染导航
  final List<Map<String, String>> _tabList = [
    {
      'icon': 'lib/assets/home_normal.png', // 正常图标
      'active_icon': 'lib/assets/home_active.png', // 激活图标
      'text': '首页',
    },
    {
      'icon': 'lib/assets/pro_normal.png', // 正常图标
      'active_icon': 'lib/assets/pro_active.png', // 激活图标
      'text': '分类',
    },
    {
      'icon': 'lib/assets/cart_normal.png', // 正常图标
      'active_icon': 'lib/assets/cart_active.png', // 激活图标
      'text': '购物车',
    },
    {
      'icon': 'lib/assets/my_normal.png', // 正常图标
      'active_icon': 'lib/assets/my_active.png', // 激活图标
      'text': '我的',
    },
  ];

  int _currentIndex = 0;

  // 渲染导航
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (index) {
      Map<String, String> tabItem = _tabList[index];
      return BottomNavigationBarItem(
        icon: Image.asset(tabItem['icon']!, width: 30, height: 30),
        activeIcon: Image.asset(tabItem['active_icon']!, width: 30, height: 30),
        label: tabItem['text'],
      );
    });
  }

  // 定义切换组件
  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 避开安全区
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          // 放置所有需切换的组件
          children: _getChildren(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _getTabBarWidget(),
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (value) {
          _currentIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
