import 'package:flutter/material.dart';
import 'package:flutter_module/common/extensions/extensions.dart';
import 'package:flutter_module/ui/widget/exposures/exposure_widget.dart';
import 'package:flutter_module/ui/widget/exposures/exposure_provider.dart';
import 'package:flutter_module/ui/widget/loft_text.dart';

class EmbedTrackerView extends StatefulWidget {
  final ExposureController parentController;
  const EmbedTrackerView({required this.parentController, super.key});

  @override
  State<EmbedTrackerView> createState() => _EmbedTrackerViewState();
}

class _EmbedTrackerViewState extends State<EmbedTrackerView>
    with AutomaticKeepAliveClientMixin {
  ExposureController controller = ExposureController();
  ExposureController childController = ExposureController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExposureWidget(
        onExpose: () {
          debugPrint("嵌套列表显示");
        },
        onHide: (duration) {
          debugPrint("嵌套列表离开, 时长=>$duration");
        },
        childExposureControllers: [controller, childController],
        exposureController: widget.parentController,
        child: ExposureProvider(
          child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.cyanAccent,
                    child: Expanded(
                        child: ExposureProvider(
                            axis: Axis.horizontal,
                            child: ListView.builder(
                                itemCount: 20,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ExposureWidget(
                                      onExpose: () {
                                        debugPrint("嵌套列表横向Cell曝光==>$index");
                                      },
                                      onHide: (duration) {
                                        debugPrint(
                                            "嵌套列表横向Cell离开曝光==>$index, 耗时=> $duration");
                                      },
                                      exposeOnce: true,
                                      index: index,
                                      exposureController: childController,
                                      child: Container(
                                        height: double.infinity,
                                        width: 80,
                                        color: Colors.redAccent,
                                        margin: 10.rightEdge,
                                        alignment: Alignment.center,
                                        child: LFTText(
                                          "$index",
                                        ),
                                      ));
                                }))),
                  );
                } else {
                  return ExposureWidget(
                    index: index,
                    exposureController: controller,
                    onExpose: () {
                      debugPrint("嵌套列表Cell曝光==>$index");
                    },
                    onHide: (duration) {
                      debugPrint("嵌套列表Cell离开曝光==>$index, 耗时=> $duration");
                    },
                    child: Container(
                      margin: 10.topEdge,
                      width: double.infinity,
                      height: 100,
                      color: Colors.amber,
                      alignment: Alignment.center,
                      child: LFTText(
                        "$index",
                      ),
                    ),
                  );
                }
              }),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
