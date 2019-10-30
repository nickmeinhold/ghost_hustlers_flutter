# ghost_hustlers_flutter

A new Flutter project.

## Missing files 

- run `flutter pub get`



Unity  
- Add ARCore Settings with your API Keys 

Unity build for Android 
- export project to GhostHustlersUnity/androidExport 
- copy strings.xml from launcher to unityLibrary 

run Unity build for iOS 
- open Player Settings -> ARCore 
  - add API Keys (will be ignored by git)
  - set iOS Support enabled
- export project to GhostHustlersUnity/iosBuild

build UnityFramework 
- File -> Workspace Settings 
  - use new build system 
  - set Derived Data to relative to project 
- add `Data` folder to UnityFramework target membership 
- set the UnityFramework as the active scheme 
- Product -> Build 

iOS 
- run pod install
- download GoogleService-Info.plist from firebase and add to ios/Runner/
- build, add missing libs (will be fixed later) then build 
