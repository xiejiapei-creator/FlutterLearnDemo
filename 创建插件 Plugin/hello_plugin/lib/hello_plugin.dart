import 'hello_plugin_platform_interface.dart';

class HelloPlugin {
  /// 返回的是一个 Future 对象，因为获取设备平台版本信息是一个异步操作，需要等待结果返回后再处理
  Future<String?> getPlatformVersion() {
    // 该方法是通过 HelloPluginPlatform 类的 instance 单例对象静态属性来调用的
    return HelloPluginPlatform.instance.getPlatformVersion();
  }

  /// 返回用户 ID
  Future<String?> getUserId() {
    return HelloPluginPlatform.instance.getUserId();
  }
}