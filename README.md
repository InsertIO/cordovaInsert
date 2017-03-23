# Cordova Plugin For Insert Framework


The purpose of this code is to allow hybrid applications to use the native insert SDK. Using the Insert SDK together with this plug-in allows a hybrid app to trigger inserts using custom code.

Register for an insert account at [https://insert.io](https://insert.io)

# Preconditions

## Create apps in the Insert console

For each of your cordova apps you have to create an Insert app in the Insert console.

Open the Insert console in your account and select "Apps". Click the "Add New App" button and follow the instructions.

For each Insert app open the "SDK Integration" sections and grab the following information.<br>
You need to provide those information as plugin variables during the plugin's installation.<br>
You can ignore all the setup instructions in the SDK Integration document, since this plugin does handle all that for 
you automatically.

## Collect required variables for plugin installation

### All supported platforms need

#### `COMPANY_NAME`

This is equal to your `companyname.insert.io` subdomain but you can also find it in the SDK Integrations document under "Step 3" in the `initSDK` code call.

### Android

#### `ANDROID_URL_ID` (Android only)

You get it from "Step 2: Manifest file" of the SDK Integration instructions.

`<data android:scheme="insert-hexnumber"/>` use **only** the `hexnumber`

This `hexnumber` is your `ANDROID_URL_ID`.


#### `ANDROID_APP_KEY` (Android only)

From Step 3: Add Initialization Code

```
Insert.initSDK(
    this,
    "ANDROID_APP_KEY", 
    "COMPANY_NAME", 
    null);
```

This also shows your `COMPANY_NAME` again.


### iOS

#### `INSERT_IOS_URL_ID`

You get it from "Step 2: Set a URL Scheme" of the SDK Integration instructions.

`Set URL Schemes to insert-hexnumber`. use **only** the `hexnumber`

This `hexnumber` is your `IOS_URL_ID`.

#### `IOS_APP_KEY`

You get it from "Step 3: Add Initialization Code

```
[[InsertManager sharedManager]
initSDK:@"IOS_APP_KEY" companyName: @"COMPANY_NAME"];
``` 

This also shows your `COMPANY_NAME` again.


Adding the Insert SDK to your Cordova app
=========================================

If you have git installed, run:

```
cordova plugin add --save https://github.com/InsertIO/cordovaInsert.git --variable COMPANY_NAME="yourcompanyname" ...
```

If git is not installed, download this repository to your machine and run:

```
cordova plugin add --save <folder-on-your-machine> --variable COMPANY_NAME="yourcompanyname" ...
```

Remember to specify all `--variable` for your platform(s).

You have to specify the `COMPANY_NAME` but can omit ANDROID_??? or IOS_??? keys if you don't have an app for that platform or don't want to use Insert in this app.

# [API](./api.md)

How to use
==========
- Within the Insert console go to your app and create a custom event (say "userLogin"). 
- Create a new insert and under the Triggers tab use a trigger type of custom event. Select "userLogin" as the event.
- In your javascript code use the following code to trigger the insert:


```
window.cordova.plugins.InsertIO.eventOccurred('userLogin', {});
```

License
=======
The Insert Cordova plug-in is licensed under the [Apache 2 license](./LICENSE.txt)

