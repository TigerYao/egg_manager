import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:egg_service_manager/service_manager.dart';

T byService<T extends IService>() {
  return Get.find<T>();
}

void jumpToPage(String pageName){
  Get.toNamed(pageName);
}

abstract class IService extends GetxController{
  final List<GetPage> pages = [];
  /// 增加各模块内部路由实现
   void addRoute(String routName, Widget page){
    pages.add(GetPage(name: routName, page: ()=>page));
  }

  void navigationTo(String routName,{dynamic? args}){
     Get.toNamed<dynamic>(routName,arguments: args);
  }
}

class ServiceManager {
  factory ServiceManager() => _instance ??= ServiceManager._();

  ServiceManager._();
  final List<GetPage> pages = [];
  static ServiceManager? _instance;
  final GetStorage box = GetStorage();
  late final BaseProvider provider;
  void init(){
    box.listenKey('token', onTokenChanged);
    onTokenChanged(getValue<String>('token'));
    provider = new BaseProvider();
  }

  void onTokenChanged(dynamic value){
    provider.onTokenChange(value);
  }

  T getService<T extends IService>() {
    return Get.find<T>();
  }

  Future<void> saveToken(String token){
    return writeValue('token', token);
  }

  Future<void> writeValue(String key, dynamic value)async{
    return await box.writeIfNull(key, value);
  }

  S getValue<S>(String key){
   return box.read<S>(key);
  }

  void addService<T extends IService>(T service) {
    Get.put(service);
    final List<GetPage> runts = service.pages;
    pages.addAll(runts);
  }
}
