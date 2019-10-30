//
//  UnityUtils.m
//  Runner
//
//  Created by Nicholas Meinhold on 29/10/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#include <UnityFramework/UnityFramework.h>

int g_argc;
char** g_argv;
UnityFramework* ufw;

extern "C" void InitArgs(int argc, char* argv[])
{
    g_argc = argc;
    g_argv = argv;
}

extern "C" void UnityFrameworkLoad()
{
    NSString* bundlePath = nil;
    bundlePath = [[NSBundle mainBundle] bundlePath];
    bundlePath = [bundlePath stringByAppendingString: @"/Frameworks/UnityFramework.framework"];

    NSBundle* bundle = [NSBundle bundleWithPath: bundlePath];
    if ([bundle isLoaded] == false) [bundle load];

    ufw = [bundle.principalClass getInstance];
    if (![ufw appController])
    {
        // unity is not initialized
        [ufw setExecuteHeader: &_mh_execute_header];
    }
}

extern "C" UnityView* getUnityView() {
    return [[ufw appController] unityView];
}

extern "C" void UnityRun()
{
    [ufw setDataBundleId: "com.unity3d.framework"];
    [ufw runEmbeddedWithArgc: g_argc argv: g_argv appLaunchOpts: nil];
    
}

