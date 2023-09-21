import UIKit
import Flutter
import CoreMotion
import frmBixolonUPOS

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let METHOD_CHANNEL_NAME = "com.example.app/method_channel"
      let PRESSURE_CHANNEL_NAME = "com.example.app/event_channel"
      let pressureStreamHandler = PressureStreamHandler()
      
      let bixolon = UPOSPrinterController()
      let printer = UPOSPrinter()
      
      
      var p1 = UPOSDeviceObjects1.instance.printerCon
      let pL1 = UPOSDeviceObjects1.instance.printerList


      class UPOSDeviceObjects1:NSObject {
          static let instance = UPOSDeviceObjects1()
          var printerCon  = UPOSPrinterController()
          var printerList = UPOSPrinters()
          
          override init() {
              super.init()
              printerList = printerCon.getRegisteredDevice() as! UPOSPrinters
          }
      }
      
      var devices:UPOSDevices {
          get { return pL1 }
      }

      
      
      let PRINT_CHANNEL_NAME = "com.example.app/print_channel"
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      let methodChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
      
      methodChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch call.method {
          case "isSensorAvailable":
              result(CMAltimeter.isRelativeAltitudeAvailable())
          default:
              result(FlutterMethodNotImplemented)
          }
      })
      
      let pressureChannel = FlutterEventChannel(name: PRESSURE_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
      pressureChannel.setStreamHandler(pressureStreamHandler)
      
      
      let printChannel = FlutterMethodChannel(name: PRINT_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
      
      printChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch call.method {
          case "connect":
//              result(p1.connect("SPP-R310"))
//              print("\(p1.getPrinterStatus())")
 //             p1.open("SPP-R310", address: "74:F0:7D:AA:31:3C")
 //             result(p1.printBarcode(2, data: "1234567890123", symbology: 104, height: 100, barWidth: 2, alignment: -1, textPostion: -13))
              result(
                UPOSDeviceObjects1().printerCon.description
              )
          default:
              result(FlutterMethodNotImplemented)
          }
      })
      
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
