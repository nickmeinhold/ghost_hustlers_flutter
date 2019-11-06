import UIKit
import Flutter
import UnityFramework

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UnityFrameworkListener, NativeCallsProtocol {
    
    var ufw: UnityFramework?
    var flutter_window: UIWindow?
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        flutter_window = window
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let unityChannel = FlutterMethodChannel(name: "co.enspyr.ghost_hustlers_flutter/unity", binaryMessenger: controller.binaryMessenger)
        unityChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if call.method == "showUnity" {
                if self.ufw == nil { // load and run
                    let ufwPath = Bundle.main.bundlePath + "/Frameworks/UnityFramework.framework"
                    self.ufw = Bundle(path: ufwPath)?.principalClass?.getInstance()
                    if self.ufw?.appController() == nil {
                        let machineHeader = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
                        machineHeader.pointee = _mh_execute_header
                        self.ufw?.setExecuteHeader(machineHeader)
                    }
                    self.ufw?.setDataBundleId("com.unity3d.framework")
                    self.ufw?.register(self)
                    (NSClassFromString("FrameworkLibAPI") as! FrameworkLibAPI.Type).registerAPIforNativeCalls(self)
                    self.ufw?.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: launchOptions)
                }
                else {
                    self.ufw?.showUnityWindow()
                }
                return
            }
            
            // if no handlers picked up the message, return unimplemented error
            result(FlutterMethodNotImplemented)
            
        })
    
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // function for Unity to call 
    func showHostMainWindow(_ color: String!) {
        
        // pass true to allow reload but this results in a crash
        // passing true does not crash when window is removed from the scene
        self.ufw?.unloadApplication(false)
        
        flutter_window?.makeKeyAndVisible()
        
    }
    
    // Callback from UnityFrameworkListener
    func unityDidUnload(_ notification: Notification!) {
        ufw?.unregisterFrameworkListener(self)
        ufw = nil
    }
    
}
