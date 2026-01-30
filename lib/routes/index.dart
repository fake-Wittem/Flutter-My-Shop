// 管理路由
import 'package:flutter/material.dart';
import 'package:my_shop/pages/Login/index.dart';
import 'package:my_shop/pages/Main/index.dart';

// 返回APP根组件
Widget getRootWidget() {
  return MaterialApp(
    initialRoute: '/',
    // 命名路由
    routes: getRootRoutes(),
  );
}

// 返回APP路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    '/': (context) => MainPage(), // 主页
    '/login': (context) => LoginPage(), // 登录页
  };
}
