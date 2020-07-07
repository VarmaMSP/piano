import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

TabController useTabController({@required int length}) {
  final vsync = useSingleTickerProvider();

  return Hook.use(_TabControllerHook(length: length, vsync: vsync));
}

class _TabControllerHook extends Hook<TabController> {
  const _TabControllerHook({this.length, this.vsync});

  final int length;
  final TickerProvider vsync;

  @override
  _TabControllerHookState createState() => _TabControllerHookState();
}

class _TabControllerHookState
    extends HookState<TabController, _TabControllerHook> {
  TabController _tabController;

  @override
  void initHook() {
    super.initHook();
    _tabController = TabController(
      length: hook.length,
      vsync: hook.vsync,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  TabController build(BuildContext context) {
    return _tabController;
  }
}
