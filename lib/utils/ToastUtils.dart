// 全局消息提示工具
import 'package:flutter/material.dart';

class Toastutils {
  static bool showLoading = false;

  static void showToast(BuildContext context, String? message) {
    if (Toastutils.showLoading) {
      return;
    }
    Toastutils.showLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      Toastutils.showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        backgroundColor: const Color.fromARGB(231, 166, 166, 166),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Text(message ?? '操作成功', textAlign: TextAlign.center),
      ),
    );
  }
}
