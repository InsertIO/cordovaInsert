# Cordova Plugin For Insert Framework


The purpose of this code is to allow hybrid applications to use the native insert SDK. Using the Insert SDK together with this plug-in allows a hybrid app to trigger inserts using custom code.

Register for an insert account at [https://insert.io](https://insert.io)

# Preconditions

## Create apps in the Insert console

For each of your cordova apps you have to create an Insert app in the Insert console.

Open the Insert console in your account and select "Apps". Click the "Add New App" button and follow the instructions.

For each Insert App open the "SDK Integration" section and collect the information mentioned below. (See "Collect required variables for plugin installation" section)<br>
You need to provide the information you've seen in the insert console as plugin variables during the plugin's installation.<br>
You can ignore all the setup instructions in the insert console, since this plugin handles everything for you automatically.

## Collect required variables for plugin installation

### All supported platforms need

#### `COMPANY_NAME`

This is equal to your `companyname.insert.io` subdomain but you can also find it in the SDK Integrations document under "Step 3" in the `initSDK` code call.

### Android

#### `ANDROID_URL_ID`

You get it from "Step 2: Manifest file" of the SDK Integration instructions.

> `<data android:scheme="insert-hexnumber"/>` use **only** the `hexnumber`

This `hexnumber` is your `ANDROID_URL_ID`.


#### `ANDROID_APP_KEY`

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

#### `IOS_URL_ID`

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

```
1) git clone https://github.com/InsertIO/cordovaInsert.git (clone it into some directory, e.g: /path/to/cordovaInsertPluginFolder)
2) cd  /path/to/cordovaInsertPluginFolder
3) git checkout hotfix/changes_to_init_pk_pr (This is the plugin version for the pure JS)
4) cd /path/to/your/project/ 
5) cordova plugin add --save /path/to/cordovaInsertPluginFolder --variable COMPANY_NAME="yourcompanyname" --variable ANDROID_APP_KEY=“appKeyHere” --variable ANDROID_URL_ID=“urlHexIdHere”
```

Remember to specify all `--variable` for your platform(s):

| iOS | Android |
|-----|---------|
| `--variable IOS_APP_KEY` | `--variable ANDROID_APP_KEY` |
| `--variable IOS_URL_ID`  | `--variable ANDROID_URL_ID`  |

You always have to specify the `COMPANY_NAME` but can omit ANDROID_??? or IOS_??? keys if you don't have an app for that platform or don't want to use Insert in this app.

# [API](./api.md)

How to use
==========
Example usage:
- First, call window.cordova.plugins.InsertIO.initSDK(userAttributes, visitorId, accountId) as early as possible in your app flow. (The parameters userAttributes, visitorId and accountId can be null)
- Within the Insert console go to your app and create a custom event (say "userLogin"). 
- Create a new insert and under the Triggers tab use a trigger type of custom event. Select "userLogin" as the event.
- In your javascript code use the following code to trigger the insert:
window.cordova.plugins.InsertIO.eventOccurred('userLogin', {});

##The functions that the plugin exports are:
1) initSDK(userAttributes, visitorId, accountId) - should always be called as early as possible
2) dismissVisibleInserts - in order to dismiss all visible inserts.
3) eventOccured(event, params) (As demonstrated in the example)
4) setUserAttributes(userAttrMap) - set the user attributes.
5) setPushId(id) - to set the push id.

Push support
============
1) Add push notification plugin (https://github.com/phonegap/phonegap-plugin-push):

   ```
   cordova plugin add phonegap-plugin-push --variable SENDER_ID="YOUR_SENDER_ID"
   ```

   make sure you replace SENDER_ID with your own sender id.
2) Add this code in your index.js in the onDeviceReady function:

```

	var push = PushNotification.init({ "android": {"senderID": "YOUR_SENDER_ID"},
         "ios": {"alert": "true", "badge": "true", "sound": "true"}, "windows": {} } );

    push.on('registration', function(data) {
         console.log("gcm registration");
         console.log(data.registrationId);
         window.plugins.Insert.setPushId(data.registrationId);
    });

    push.on('notification', function(data) {
        console.log(data.message);
        console.log(data.title);
        console.log(data.count);
        console.log(data.image);
        console.log(data.additionalData);
    });

    push.on('error', function(e) {
        console.log(e.message);
    });

```

3) You're ready to go. Enter insert console and configure your push insert.

License
=======
The Insert Cordova plug-in is licensed under the [Apache 2 license](./LICENSE.txt)
