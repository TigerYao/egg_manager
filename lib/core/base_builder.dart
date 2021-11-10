import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

class BaseBuild<T extends BaseController> extends GetBuilder<T> {
  final GetControllerBuilder<T>? builder;
  final bool global;
  final Object? id;
  final String? tag;
  final bool? autoRemove;
  final bool? assignId;
  final Object Function(T value)? filter;
  final void Function(State state)? initState, dispose, didChangeDependencies;
  final void Function(GetBuilder oldWidget, State state)? didUpdateWidget;
  final T? init;

  BaseBuild({
    Key? key,
    this.init,
    this.global = true,
    @required this.builder,
    this.autoRemove = true,
    this.assignId = false,
    this.initState,
    this.filter,
    this.tag,
    this.dispose,
    this.id,
    this.didChangeDependencies,
    this.didUpdateWidget,
  }) : super(key: key,
      init: init,
      global: global,
      builder: builder,
      autoRemove: autoRemove,
      assignId: assignId,
      initState: initState,
      filter: filter,
      tag: tag,
      dispose: dispose,
      id: id,
      didChangeDependencies: didChangeDependencies,
      didUpdateWidget: didUpdateWidget
  );

}