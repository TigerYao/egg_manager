import 'dart:async';
import 'package:egg_manager/api/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'base_provider.dart';

T byService<T extends IService>() {
  return Get.find<T>();
}

void jumpToPage(String pageName, {dynamic args, Bindings? binding}) {
  Get.toNamed(pageName, arguments: args);
}

abstract class IService extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  GetPage? getPages() {
    return null;
  }
}

class ServiceManager {
  factory ServiceManager() => _instance ??= ServiceManager._();

  ServiceManager._();

  static ServiceManager? _instance;
  final GetStorage box = GetStorage();
  final BaseProvider provider = Get.put(BaseProvider());

  void init() {
    if (box.hasData('token')) {
      box.listenKey('token', onTokenChanged);
      onTokenChanged(getValue<String>('token'));
    }
  }

  void onTokenChanged(dynamic value) {
    provider.onTokenChange(value);
  }

  T getService<T extends IService>() {
    return Get.find<T>();
  }

  Future<void> saveToken(String token) {
    return writeValue('token', token);
  }

  Future<void> writeValue(String key, dynamic value) async {
    return await box.writeIfNull(key, value);
  }

  S? getValue<S>(String key) {
    return box.read<S>(key);
  }

  void navigationTo(String routName, {dynamic args}) {
    Get.toNamed<dynamic>(routName, arguments: args);
  }

  void addService<T extends IService>(T service) {
    if (service.getPages() != null)
      AppPages.pages.add(service.getPages()!);
    Get.lazyPut(() => service);
  }
}
