<a name="cordova.plugins.module_InsertIO"></a>

## InsertIO

* [InsertIO](#cordova.plugins.module_InsertIO)
    * [.initSDK([userAttributes], [visitorId], [accountId], [success], [error])](#cordova.plugins.module_InsertIO.initSDK)
    * [.dismissVisibleInserts([success], [error])](#cordova.plugins.module_InsertIO.dismissVisibleInserts)
    * [.eventOccurred(event, [params], [success], [error])](#cordova.plugins.module_InsertIO.eventOccurred)
    * [.setUserAttributes(attributes, [success], [error])](#cordova.plugins.module_InsertIO.setUserAttributes)
    * [.setPushId([pushId], [success], [error])](
    #cordova.plugins.module_InsertIO.setPushId)

<a name="cordova.plugins.module_InsertIO.initSDK"></a>
### InsertIO.initSDK([userAttributes], [visitorId], [accountId], [success], [error])
Initialise the native SDK.

You should call this as soon as possible in the app.
Probably before tearing down the splashscreen when you plan to serve
"App Start" triggered Inserts.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  
**See**

- Insert.setUserAttributes


| Param | Type | Description |
| --- | --- | --- |
| [userAttributes] | <code>object</code> | object containing user attributes |
| [visitorId] | <code>string</code> | visitor id string |
| [accountId] | <code>string</code> | account id string |
| [success] | <code>function</code> | called when initialisation succeeded |
| [error] | <code>function</code> | called when initialisation fails |

<a name="cordova.plugins.module_InsertIO.dismissVisibleInserts"></a>

### InsertIO.dismissVisibleInserts([success], [error])
Hides all visible inserts.

Since inserts can carry private information you 
should call this function when your user logs out of you app.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  

| Param | Type |
| --- | --- |
| [success] | <code>function</code> | 
| [error] | <code>function</code> | 

<a name="cordova.plugins.module_InsertIO.eventOccurred"></a>

### InsertIO.eventOccurred(event, [params], [success], [error])
Sends an event to Insert.

You have to register events first in your Insert dashboard.
Sending unregistered events has no effect.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  

| Param | Type | Description |
| --- | --- | --- |
| event | <code>string</code> | - |
| [params] | <code>object</code> | user defined event parameters |
| [success] | <code>function</code> | called when the event was handed over to the native SDK |
| [error] | <code>function</code> | called when the event could not be handed over to the native SDK |

<a name="cordova.plugins.module_InsertIO.setPushId"></a>

### InsertIO.setPushId([pushId], [success], [error])
Sets the push Id.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  

| Param | Type | Description |
| --- | --- | --- |
| [pushId] | <code>string</code> | the push id |
| [success] | <code>function</code> | called when the event was handed over to the native SDK |
| [error] | <code>function</code> | called when the event could not be handed over to the native SDK |

<a name="cordova.plugins.module_InsertIO.setUserAttributes"></a>

### InsertIO.setUserAttributes(attributes, [success], [error])
Set user attributes to tailor specific Inserts to users.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  
**Remarks**: You do not need to wrap your values into quotation marks as the article mentions.
The cordova plugin is taking care of that for you.  
**See**: [How to: Set custom events to be used as triggers & in audience](https://support.insert.io/hc/en-us/articles/115000140685-How-to-Set-custom-events-to-be-used-as-triggers-in-audience)  

| Param | Type | Description |
| --- | --- | --- |
| attributes | <code>object</code> | A string key - any value |
| [success] | <code>function</code> | called when the attributes were set |
| [error] | <code>function</code> | called when the attributes could not be set |

