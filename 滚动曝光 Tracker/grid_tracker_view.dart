import 'package:flutter/material.dart';
import 'package:flutter_module/ui/widget/loft_text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_module/ui/widget/exposures/exposure_provider.dart';
import 'package:flutter_module/ui/widget/exposures/exposure_widget.dart';

class GridTrackerView extends StatefulWidget {
  final ExposureController parentController;
  const GridTrackerView({required this.parentController, super.key});

  @override
  State<GridTrackerView> createState() => _GridTrackerViewState();
}

class _GridTrackerViewState extends State<GridTrackerView>
    with AutomaticKeepAliveClientMixin {
  final ExposureController exposureController = ExposureController();

  Widget picWidget(index) {
    return ExposureWidget(
        onExpose: () {
          debugPrint("瀑布流Cell曝光=>$index");
        },
        onHide: (duration) {
          debugPrint("瀑布流Cell离开曝光=> $index $duration");
        },
        exposureController: exposureController,
        child: Container(
          height: 260,
          color: Colors.cyanAccent,
          child: Image.network("http://gw.alicdn.com/bao/uploaded/i1/O1CN01aVbGSM1bLgj8i2Bgw_!!0-fleamarket.jpg_760x760q90.jpg"),
        ));
  }

  Widget textWidget(index) {
    return Container(
      height: 200,
      color: Colors.redAccent,
      alignment: Alignment.center,
      child: const LFTText(
        "这是个没有曝光的文本组件",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExposureWidget(
        onExpose: () {
          debugPrint("进入瀑布流页面");
        },
        onHide: (duration) {
          debugPrint("瀑布流页面离开, 时长=>$duration");
        },
        childExposureControllers: [exposureController],
        exposeDebounce: 0,
        exposureController: widget.parentController,
        child: ExposureProvider(
            child: MasonryGridView.count(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemCount: 75,
          itemBuilder: (context, index) {
            return index % 4 == 0 ? textWidget(index) : picWidget(index);
          },
          crossAxisCount: 2,
        )));
  }

  @override
  bool get wantKeepAlive => true;
}
