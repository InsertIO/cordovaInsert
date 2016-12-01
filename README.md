# Cordova Plugin For Insert Framework


* Create your app:

```
cordova create hallo com.example.hello HelloWorld

cd hallo

cordova platform add iOS
cordova platform add android
```

* Add The Plugin:

> iOS:
- Download the insert framework from this link
- Unzip to extract the Insert framework: InsertFramework.framework
- Copy InsertFramwork.framework to your project’s Frameworks directory by dragging the framework to your project. When prompted, check the option to“Copy items if needed”. The .xcworkspace file located in /.../< yourApp >/platforms/ios
- Under Build Phases | Link Binaries With Libraries, verify that InsertFramework.framework is listed
Under  General | Embedded Binaries, press the + sign and add InsertFramework.framework
- Under Build Settings | Build Options, verify that the flag  “Enable Bitcode” is set to No
- Under General | Deployment Target verify that deployment target is set for 8.0 or later. Insert only supports iOS 8 or later.
- add the plugin itself:  
```
cordova plugin add https://github.com/InsertIO/cordovaInsert.git
```

> Android:




Example code:

```
window.plugins.Insert.eventOccured('userLogin' {
   provider : 'xxx',
   timeSinceLastSession: 'xxxxxxxx'
 });

```
