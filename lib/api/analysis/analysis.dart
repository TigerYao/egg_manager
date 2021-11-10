import 'package:egg_manager/core/service_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';

/// 统计分析服务
///
/// 统计分析服务，用于埋点。方便后续埋点的整体切换与通用信息的统一处理。
abstract class IAnalysisService extends IService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics();
  FirebaseAnalyticsObserver firebaseAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> initFirebase()async{
    await Firebase.initializeApp();
  }
  /// 发送埋点事件
  /// [eventName] 对应埋点文档中的 **eventName** 字段
  /// [action] 对应埋点文档中的 **track_action** 字段
  /// [pageName] 对应埋点文档中的 **pageName** 字段
  /// [params] 对应埋点文档中的 **event label** 字段
  Future<void> sendAnalyticsEvent(String eventName, EventAction action,
      {String? pageName, Map<String, Object?>? params});

  /// 发送 click 类型的埋点事件
  /// [category] 对应埋点文档中的 **category** 字段
  /// [pageName] 对应埋点文档中的 **pageName** 字段
  /// [params] 对应埋点文档中的 **event label** 字段
  Future<void> sendClickEvent(String eventName, {String? pageName, Map<String, Object?>? params});

  void sendEvent(String name, {Map<String, Object?>? params}){
    _analytics.logEvent(name: name,parameters: params);
  }

}

/// Event的Action类型，目前只有click类型
enum EventAction {
  /// click类型的action
  click,
  login,
  app_open,
  app_close,
  page_name
}

extension EventActionExt on EventAction {
  /// action的文本信息
  String get text {
   late String result;
    switch (this) {
      case EventAction.click:
        result = 'click';
        break;
    }
    assert(result.isNotEmpty);
    return result;
  }
}
