import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'hello_plugin_method_channel.dart';

// 定义了一个抽象类 HelloPluginPlatform 继承自 PlatformInterface 类
abstract class HelloPluginPlatform extends PlatformInterface {

  /// [HelloPluginPlatform] 类的构造函数
  /// 调用了父类 [PlatformInterface] 的构造函数来初始化实例
  /// 构造函数中传入了一个名为 token 的参数，该参数的值为下面所提到的静态对象 _token
  HelloPluginPlatform() : super(token: _token);

  // 静态变量 _token 表示验证的标识符
  // 它被声明为 final 类型，意味着它的值一旦被设置就不能再被修改
  static final Object _token = Object();

  // 静态变量 _instance 用于实现单例模式
  // 表示使用方法通道实现插件的平台特定部分
  static HelloPluginPlatform _instance = MethodChannelHelloPlugin();

  /// 定义了一个静态的 get 方法 instance
  /// 用于获取默认的 [HelloPluginPlatform] 实例
  /// instance 方法直接返回 _instance 静态变量的值，也就是 [MethodChannelHelloPlugin] 的实例
  /// 如果需要使用其他实现方式，可以通过 set instance 方法设置一个新的实例
  static HelloPluginPlatform get instance => _instance;

  /// 定义了一个静态的 set 方法 instance
  /// 用于设置默认的 [HelloPluginPlatform] 实例
  /// 传入的参数 instance 必须是 [HelloPluginPlatform] 的子类
  static set instance(HelloPluginPlatform instance) {

    // 需要调用 PlatformInterface.verifyToken 方法来验证 instance 是否是合法的子类实例
    // 第一个参数是要验证的实例对象 第二个参数是验证的标识符（token）
    // 抛出异常来标识不合法的情况
    PlatformInterface.verifyToken(instance, _token);

    // 在验证通过后将其设置为默认实例
    _instance = instance;
  }

  /// 表示获取插件的平台版本
  Future<String?> getPlatformVersion() {
    // 具体的平台实现需要继承 HelloPluginPlatform 并实现 getPlatformVersion() 方法
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// 获取用户ID
  Future<String?> getUserId() {
    throw UnimplementedError('方法未找到');
  }
}
