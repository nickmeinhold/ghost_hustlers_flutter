import UIKit
import Flutter
import UnityFramework

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UnityFrameworkListener {
    
    var ufw: UnityFramework?
    var ufwBundle: Bundle?
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let unityChannel = FlutterMethodChannel(name: "co.enspyr.ghost_hustlers_flutter/unity",
                                                  binaryMessenger: controller.binaryMessenger)
        unityChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if call.method == "loadUnity" {
                let ufwPath = Bundle.main.bundlePath + "/Frameworks/UnityFramework.framework"
                self.ufwBundle = Bundle(path: ufwPath)
                self.ufw = self.ufwBundle?.principalClass?.getInstance()
                if self.ufw?.appController() == nil {
                    let machineHeader = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
                    machineHeader.pointee = _mh_execute_header
                    self.ufw?.setExecuteHeader(machineHeader)
                }
                self.ufw?.setDataBundleId("com.unity3d.framework")
                self.ufw?.register(self)
                self.ufw?.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: launchOptions)
                return
            }
            
            // if no handlers picked up the message, return unimplemented error
            result(FlutterMethodNotImplemented)
            
        })
    
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // Callback from UnityFrameworkListener
    func unityDidUnload(_ notification: Notification!) {
        ufw?.unregisterFrameworkListener(self)
        ufw = nil
        // Push the flutter view I guess
        //UnityEmbeddedSwift.hostMainWindow?.makeKeyAndVisible()
    }
    
}
