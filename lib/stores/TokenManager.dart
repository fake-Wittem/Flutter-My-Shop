// 管理用户token

import 'package:my_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tokenmanager {
  // 返回实例对象
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = '';
  // 初始化Token
  Future<void> init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? '';
  }

  // 设置Token
  Future<void> setToken(String token) async {
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, token);
    _token = token;
  }

  // 获取Token
  String getToken() {
    return _token;
  }

  // 删除Token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = '';
  }
}

final tokenManager = Tokenmanager();
