import Flutter
import UIKit

/// 一个 Flutter 插件的 iOS 实现
/// 插件名为 [HelloPlugin]，实现了 [FlutterPlugin] 接口
public class HelloPlugin: NSObject, FlutterPlugin {
    /// 方法名称
    private enum MethodName: String {
        case getUserId
        case getPlatformVersion
        case getDeviceInfo
    }
    
    /// 意味着它必须实现 [FlutterPlugin] 接口中的 register 方法
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        // 在 register 方法中，插件会创建一个 [FlutterMethodChannel] 对象
        // [FlutterMethodChannel] 是 Flutter 框架提供的一个用于在 Dart 代码和原生代码之间进行通信的类
        // 在创建时需要指定通道的名称和消息传递器（binary messenger）
        // 通道的名称为 hello_plugin，消息传递器则使用了 registrar 对象的 messenger() 方法
        // 这个方法返回了一个 BinaryMessenger 对象，用于在 Dart 代码和原生代码之间传递消息
        let channel = FlutterMethodChannel(name: "hello_plugin", binaryMessenger: registrar.messenger())
        
        // 将插件实例 instance 注册为 channel 对象的方法调用委托
        // 以便在 Flutter 通过 channel 对象调用原生代码中的方法时
        // 可以由 instance 对象来处理这个方法调用
        let instance = HelloPlugin()
        
        // 然后将这个 channel 注册到 Flutter 的插件注册器中
        // Flutter 就可以通过这个通道来调用原生代码中的方法，而原生代码也可以通过这个通道向 Flutter 发送消息
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    /// 插件的主要逻辑在 handle 方法中实现
    /// handle 方法用于处理从 Flutter 发送过来的方法调用或事件通知，并返回相应的结果给 Flutter
    /// 当 Flutter 调用插件的某个方法时，Flutter 会将这个调用封装为一个 FlutterMethodCall 对象
    /// 并将这个对象作为参数传递给 handle 方法
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        /// 插件可以从这个对象中获取调用的方法名和参数，并根据需要执行相应的操作
        /// 插件使用 FlutterResult 对象将这个字符串返回给 Flutter
        switch MethodName(rawValue: call.method) {
        case .getUserId:
            // 获取用户ID
            result("xiejiapei")
        case .getPlatformVersion:
            // 在这个例子中，插件只是返回一个字符串，该字符串包含当前 iOS 系统的版本号
            result("iOS " + UIDevice.current.systemVersion)
        case .getDeviceInfo:
            // Do something
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
