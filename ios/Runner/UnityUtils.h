//
//  UnityUtils.h
//  Runner
//
//  Created by Nicholas Meinhold on 29/10/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef UnityUtils_h
#define UnityUtils_h

#ifdef __cplusplus
extern "C" {
#endif

    // 1
    void InitArgs(int argc, char* argv[]);
    // 2
    void UnityFrameworkLoad();
    // 3
    UnityView* getUnityView()
    // ?
    void UnityRun();

#ifdef __cplusplus
} // extern "C"
#endif

#endif /* UnityUtils_h */
