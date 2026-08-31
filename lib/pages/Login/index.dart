import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/api/user.dart';
import 'package:my_shop/stores/TokenManager.dart';
import 'package:my_shop/stores/UserController.dart';
import 'package:my_shop/utils/LoadingDialog.dart';
import 'package:my_shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController(); // 账号控制器
  TextEditingController _pwdController = TextEditingController(); // 密码控制器
  final UserController _userController = Get.find();

  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '账号密码登录',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // 账号Widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '账号不能为空';
        }
        if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
          return '手机号格式不正确';
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        hintText: '请输入账号',
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 密码Widget
  Widget _buildPwdTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '密码不能为空';
        }
        if (!RegExp(r'^[a-zA-Z0-9_]{6,16}$').hasMatch(value)) {
          return '请输入6-16位的字母数字或下划线';
        }
        return null;
      },
      controller: _pwdController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        hintText: '请输入密码',
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  bool _isChecked = false;
  // 勾选协议Widget
  Widget _buildCheckBox() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            _isChecked = value ?? false;
            setState(() {});
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '查看并同意'),
              TextSpan(
                text: '《隐私条款》',
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: '和'),
              TextSpan(
                text: '《用户协议》',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 登录按钮Widget
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_key.currentState!.validate()) {
            if (_isChecked) {
              _login();
            } else {
              Toastutils.showToast(context, '请勾选用户协议');
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(25),
          ),
        ),
        child: Text('登录', style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  // 登录
  void _login() async {
    try {
      LoadingDialog.show(context, message: '登录中...');
      final res = await loginAPI({
        'account': _phoneController.text,
        'password': _pwdController.text,
      });
      _userController.updateUserInfo(res);
      tokenManager.setToken(res.token); // 写入token
      Toastutils.showToast(context, '登录成功');
      Navigator.pop(context);
    } catch (e) {
      Toastutils.showToast(context, (e as DioException).message);
    } finally {
      LoadingDialog.hide(context);
    }
  }

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户登录', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildPwdTextField(),
              SizedBox(height: 20),
              _buildCheckBox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
