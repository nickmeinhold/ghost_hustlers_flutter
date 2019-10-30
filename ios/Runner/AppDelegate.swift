import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // store the commandline args for later when running Unity
    SetupUnity(CommandLine.argc, CommandLine.unsafeArgv, launchOptions)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let unityChannel = FlutterMethodChannel(name: "co.enspyr.ghost_hustlers_flutter/unity",
                                              binaryMessenger: controller.binaryMessenger)
    unityChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
        // Note: this method is invoked on the UI thread.
        guard call.method == "showUnity" else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        controller.present(getUnityView(), animated: true, completion: nil)
        
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
