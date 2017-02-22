# Cordova Plugin For Insert Framework


The purpose of this code is to allow hybrid applications to use the native insert SDK. Using the Insert SDK together with this plug-in allows a hybrid app to trigger inserts using custom code.

Register for an insert account at https://insert.io


Adding the Insert SDK to a Cordova app
======================================
* To create a new Cordova app (if needed):

```
cordova create hello com.example.hello HelloWorld

cd hello

cordova platform add ios
cordova platform add android
```
* Add The Insert Plugin:

If you have git installed run command below
```
cordova plugin add https://github.com/InsertIO/cordovaInsert.git
```
If git is not installed, download this repository to your machine and run:
```
cordova plugin add <folder-on-your-machine>
```

* Add the Insert SDK

Open the Insert console and create an app.  then follow the installation instructions to integrate the SDK into your app. Specifically, you have to call the InitSDK function on the native part of your app
Make sure that once integrated, you see a success message in the Android Studio or XCode logs.


How to use
==========
- Within the Insert console go to your app and create a custom event (say "userLogin"). 
- Create a new insert and under the Triggers tab use a trigger type of custom event. Select "userLogin" as the event.
- In your javascript code use the following code to trigger the insert:


```
window.plugins.Insert.eventOccurred('userLogin', {
   key1 : 'value1',
   key2 : 'value2'
 });

```

License
=======
The Insert Cordova plug-in is licensed under the Apache 2 license

