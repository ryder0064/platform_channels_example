import Flutter
import UIKit

public class SwiftBatterylevelPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "batterylevel", binaryMessenger: registrar.messenger())
        let instance = SwiftBatterylevelPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "getBatteryLevel":
            let batterLevel = getBatteryLevel()
            if(batterLevel == -1) {
                result(FlutterError(code: "UNAVAILABLE", message: "Battery info unavailable", details: nil));
            } else {
                result("iOS batterLevel = \(batterLevel * 100)%")
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getBatteryLevel() -> Float {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == .unknown {
            return -1;
        } else {
            return UIDevice.current.batteryLevel
        }
    }
}
