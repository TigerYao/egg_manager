import 'package:egg_manager/service_manager.dart';
import 'package:flutter/material.dart';

typedef LoginCallback = Function(String token);

abstract class ILaunch extends IService {
  /// 显示升级提醒
  void showNewVersionUpdate({bool forceShow = false});

  bool isLogin();

  void setIsLogin(bool isLogin);

  Widget loginWidget({required Widget loginWidget, required Widget logoutWidget});

  String getHomeName();

}
