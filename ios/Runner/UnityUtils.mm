//
//  UnityUtils.m
//  Runner
//
//  Created by Nicholas Meinhold on 29/10/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#include "UnityUtils.h"

int g_argc;
char** g_argv;
NSDictionary* g_launchOptions;
UnityFramework* ufw;

extern "C" void SetupUnity(int argc, char* argv[], NSDictionary* launchOptions)
{
    g_argc = argc;
    g_argv = argv;
    g_launchOptions = launchOptions;

    NSString* bundlePath = nil;
    bundlePath = [[NSBundle mainBundle] bundlePath];
    bundlePath = [bundlePath stringByAppendingString: @"/Frameworks/UnityFramework.framework"];

    NSBundle* bundle = [NSBundle bundleWithPath: bundlePath];
    if ([bundle isLoaded] == false) [bundle load];

    ufw = [bundle.principalClass getInstance];
    if (![ufw appController])
    {
        // Initialize Unity for a first time
        [ufw setExecuteHeader: &_mh_execute_header];

        // Keep in sync with Data folder Target Membership setting
        [ufw setDataBundleId: "com.unity3d.framework"];
        
        // Warmup the framework
        [ufw frameworkWarmup: g_argc argv: g_argv];
    }

}

extern "C" UIViewController* getUnityView() {
    
    // taken from Unity-iPhone/Classes/main.mm

    id app = [UIApplication sharedApplication];

    id appCtrl = [[NSClassFromString([NSString stringWithUTF8String: "UnityAppController"]) alloc] init];
    [appCtrl application: app didFinishLaunchingWithOptions: g_launchOptions];

    [appCtrl applicationWillEnterForeground: app];
    [appCtrl applicationDidBecomeActive: app];

    // end of code from Unity-iPhone/Classes/main.mm
    
    UIViewController* vc = [[ufw appController] rootViewController];
    if(vc == NULL) {
        NSException* myException = [NSException
                exceptionWithName:@"NullVCException"
                reason:@"UnityAppController VC was null"
                userInfo:nil];
        @throw myException;
    }
    return vc;
}

