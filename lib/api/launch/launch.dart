import 'package:flutter/material.dart';
import 'package:egg_manager/service_manager.dart';

abstract class ILaunch extends IService {
  String newVersion();

  /// 显示升级提醒
  void showNewVersionUpdate({bool forceShow = false});

  Widget createLaunchName();

}
