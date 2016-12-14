# Cordova Plugin For Insert Framework


The purpose of this code is to allow hybrid applications to use the native insert SDK. Using the Insert SDK together with this plug-in allows a hybrid app to trigger inserts using custom code.

Register for an insert account at https://insert.io


Adding the Insert SDK to a Cordova app
======================================
* Create your app:

```
cordova create hello com.example.hello HelloWorld

cd hello

cordova platform add ios
cordova platform add android
```

* Add the Insert SDK

Open the Insert console and create an app.  then follow the installation instructions to integrate the SDK into your app.
Make sure that once integrated, you see a success message in the Android Studio or XCode logs.

* Add The Plugin:

```
cordova plugin add https://github.com/InsertIO/cordovaInsert.git
```

Verify
======
- Within the Insert console go to your app and create a custom event (say "userLogin"). 
- Create a new insert and under the Triggers tab create a trigger type of custom event. Select "userLogin" as the event.
- In your javascript code use the following code to trigger the insert:


```
window.plugins.Insert.eventOccured('userLogin' {
   provider : 'xxx',
   timeSinceLastSession: 'xxxxxxxx'
 });

```

License
=======
The Insert Cordova plug-in is licensed under the Apache 2 license

