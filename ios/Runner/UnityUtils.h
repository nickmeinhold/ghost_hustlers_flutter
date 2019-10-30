//
//  UnityUtils.h
//  Runner
//
//  Created by Nicholas Meinhold on 29/10/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#include <UnityFramework/UnityFramework.h>

#ifndef UnityUtils_h
#define UnityUtils_h

#ifdef __cplusplus
extern "C" {
#endif

    // 
    void SetupUnity(int argc, char* argv[], NSDictionary* launchOptions);
    // 
    UIViewController* getUnityView();

#ifdef __cplusplus
} // extern "C"
#endif

#endif /* UnityUtils_h */
