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

iOS 
- download GoogleService-Info.plist from firebase and add to ios/Runner/