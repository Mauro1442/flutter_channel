import UIKit
import Flutter
import CoreMotion

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      ///
      let METHOD_CHANNEL_NAME = "com.example.app/method_channel"
      let PRESSURE_CHHANNEL_NAME = "com.example.app/event_channel"
      let pressureStreamHandler = PressureStreamHandler()
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      let methodChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
      
      methodChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch call.mmethod {
          case "isSensorAvailable":
              result(CMAltimeter.isRelativeAltitudeAvailable())
          default:
              result(FlutterMethodNtImmplemented)
          }
      })
      
      let pressureChannel = FlutterEventChannel(name: PRESSURE_CHHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
      ///
      
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
