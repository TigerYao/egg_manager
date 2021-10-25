import 'package:flutter/material.dart';
import 'package:egg_service_manager/service_manager.dart';

abstract class IAuth extends IService {
  /// 当前是否登录状态
  bool get isLogin;

  /// 如果已登录，直接返回true
  /// 否则唤起登录页，并且返回最终登录结果
  Future<bool> ensureLogin({BuildContext? context});

  /// 如果已登录，直接返回false
  /// 否则唤起注册页
  Future<bool> ensureRegister({BuildContext? context});

  Future<bool> ensureSegment({BuildContext context});

  /// 如果当前未登录，会直接返回false
  /// 当前是登录状态，会返回最终结果
  Future<bool> changePassword({BuildContext? context});

  /// 绑定手机号流程，并返回结果
  /// 如果已绑定，直接返回true
  Future<bool> ensureBindMobile({BuildContext? context});

  /// 绑定邮箱流程，并返回结果
  /// 如果已绑定，直接返回true
  Future<bool> ensureBindEmail({BuildContext? context});

  /// 手动退出登录
  void logout();

  /// 踢出登录，不要手动调用
  void kickOff({BuildContext? context});

  void openWebView(String url, {String? title, BuildContext? context});

  /// 前往注册页
  Future<void> navigateToRegister(BuildContext? context);

  /// 弹出 banIP 弹窗
  Future<void> showBanTipDialog(BuildContext? context, String title, String content);

  /// 发送邮箱验证码
  Future<bool> sendEmailCode({
    required BuildContext context,
    required String email,
  });

  /// 发送手机号验证码
  Future<bool> sendPhoneCode({
    required BuildContext context,
    required String countryCode,
    required String phone,
  });

  /// 前往注册页并判断是否来自引导页
  Future<void> popAndNavigateToRegister(BuildContext context, {bool isFromGuide = false});
}
