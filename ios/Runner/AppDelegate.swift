import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // store the commandline args for later when running Unity
    InitArgs(CommandLine.argc, CommandLine.unsafeArgv)
    UnityFrameworkLoad()
    
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
        
        let navigationController:UINavigationController = controller.navigationController
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UnityVC") as? UnityVC
        vc.view = getUnityView()
        navigationController.pushViewController(vc, animated: true)
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
