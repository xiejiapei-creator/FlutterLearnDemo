import 'package:flutter/material.dart';
import 'package:flutter_module/common/extensions/extensions.dart';
import 'package:flutter_module/ui/widget/exposures/exposure_widget.dart';
import 'package:flutter_module/ui/widget/exposures/exposure_provider.dart';
import 'package:flutter_module/ui/widget/loft_text.dart';

class NormalTrackerView extends StatefulWidget {
  final ExposureController parentController;
  const NormalTrackerView({required this.parentController, super.key});

  @override
  State<NormalTrackerView> createState() => _NormalTrackerViewState();
}

class _NormalTrackerViewState extends State<NormalTrackerView>
    with AutomaticKeepAliveClientMixin {
  ExposureController controller = ExposureController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExposureWidget(
        onExpose: () {
          debugPrint("普通列表显示");
        },
        onHide: (duration) {
          debugPrint("普通列表离开, 时长=>$duration");
        },
        exposeDebounce: 0,
        childExposureControllers: [controller],
        exposureController: widget.parentController,
        // 当前后台切换时不重新曝光
        exposeWhenChangeAppLifeState: false,
        child: ExposureProvider(
          child: ListView.builder(
              itemCount: 50,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              cacheExtent: 100,
              itemBuilder: (context, index) {
                return ExposureWidget(
                  index: index,
                  exposureController: controller,
                  exposeDebounce: 500,
                  onExpose: () {
                    debugPrint("普通列表cell曝光==>$index");
                  },
                  onHide: (duration) {
                    debugPrint("普通列表cell离开曝光==>$index, 耗时=> $duration");
                  },
                  child: Container(
                    margin: 10.topEdge,
                    width: double.infinity,
                    // height: 100,
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 160,
                      child: Image.network("http://gw.alicdn.com/bao/uploaded/i1/O1CN01aVbGSM1bLgj8i2Bgw_!!0-fleamarket.jpg_760x760q90.jpg"),
                    ),
                  ),
                );
              }),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
