import 'package:flutter/material.dart';
import 'package:flutter_module/ui/widget/loft_appbar.dart';
import 'package:flutter_module/ui/widget/exposures/exposure_provider.dart';
import 'package:flutter_module/ui/widget/exposures/exposure_widget.dart';
import 'package:flutter_module/ui/widget/exposures/lifecycle_mixin.dart';
import 'package:flutter_module/ui/widget/loft_scaffold.dart';
import 'package:flutter_module/ui/widget/loft_text.dart';

import 'package:flutter_module/ui/test/tracker_demo/embed_tracker_view.dart';
import 'package:flutter_module/ui/test/tracker_demo/grid_tracker_view.dart';
import 'package:flutter_module/ui/test/tracker_demo/normal_tracker_view.dart';

class TrackerPageDemo extends StatefulWidget {
  const TrackerPageDemo({super.key});

  @override
  State<TrackerPageDemo> createState() => _TrackerPageDemoState();
}

class _TrackerPageDemoState extends State<TrackerPageDemo>
    with SingleTickerProviderStateMixin, LifecycleMixin {

  /// 创建 Tabbar
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  Widget _tabbar() {
    return SizedBox(
      height: 40,
      child: TabBar(
        tabs: const [
          LFTText(
            "普通列表",
          ),
          LFTText(
            "嵌入列表",
          ),
          LFTText(
            "双瀑布流列表",
          ),
        ],
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3,
        indicatorColor: Colors.white,
      ),
    );
  }

  /// 通过指定当前页面生命周期中的列表曝光控制器, 实现前后台切换以及页面离开时上报埋点信息
  final ExposureController _exposureController = ExposureController();

  @override
  ExposureController? get exposureController => _exposureController;

  Widget _tabView() {
    return ExposureProvider(
      axis: Axis.horizontal,
      child: TabBarView(controller: _tabController, children: [
        NormalTrackerView(parentController: _exposureController),
        EmbedTrackerView(parentController: _exposureController),
        GridTrackerView(parentController: _exposureController),
      ]),
    );
  }

  /// 构建组件
  @override
  Widget build(BuildContext context) {
    return LFTScaffold(
        appBar: LFTAppBar("滑动曝光Demo", context),
        body: Column(
          children: [_tabbar(), Expanded(child: _tabView())],
        )
    );
  }
}