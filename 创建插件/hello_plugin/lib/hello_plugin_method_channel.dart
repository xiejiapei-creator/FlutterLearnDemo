import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'hello_plugin_platform_interface.dart';

/// 该类是 [HelloPluginPlatform] 接口的一个实现
/// 使用方法通道[MethodChannel]与原生平台进行交互
class MethodChannelHelloPlugin extends HelloPluginPlatform {

  /// 定义了一个名为 methodChannel 的 [MethodChannel] 对象
  /// 用于与原生平台进行通信
  /// 标记为 @visibleForTesting 时只能被测试代码中的其他类使用，而不能被生产代码中的其他类使用
  @visibleForTesting
  final methodChannel = const MethodChannel('hello_plugin');

  /// 实现了获取插件的平台版本的方法
  @override
  Future<String?> getPlatformVersion() async {
    // 该方法通过 methodChannel 对象调用原生平台上的 getPlatformVersion 方法，并返回它的结果
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// 获取用户ID
  @override
  Future<String?> getUserId() async {
    final userId = await methodChannel.invokeMethod<String>('getUserId');
    return userId;
  }
}
