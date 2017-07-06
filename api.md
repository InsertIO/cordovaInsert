<a name="cordova.plugins.module_InsertIO"></a>

## InsertIO

* [InsertIO](#cordova.plugins.module_InsertIO)
    * [.init([success], [error])](#cordova.plugins.module_InsertIO.init)
    * [.dismissVisibleInserts([success], [error])](#cordova.plugins.module_InsertIO.dismissVisibleInserts)
    * [.eventOccurred(event, [params], [success], [error])](#cordova.plugins.module_InsertIO.eventOccurred)
    * [.setUserAttributes(attributes, [success], [error])](#cordova.plugins.module_InsertIO.setUserAttributes)
    * [.setUserId(userId, [success], [error])](#cordova.plugins.module_InsertIO.setUserId)

<a name="cordova.plugins.module_InsertIO.init"></a>

### InsertIO.init([success], [error])
Initialise the native SDK.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  
**See**

- Insert.setUserAttributes
- Insert.setUserId


| Param | Type | Description |
| --- | --- | --- |
| [success] | <code>function</code> | called when initialisation succeeded |
| [error] | <code>function</code> | called when initialisation fails |

<a name="cordova.plugins.module_InsertIO.dismissVisibleInserts"></a>

### InsertIO.dismissVisibleInserts([success], [error])
Hides all visible inserts.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  

| Param | Type |
| --- | --- |
| [success] | <code>function</code> | 
| [error] | <code>function</code> | 

<a name="cordova.plugins.module_InsertIO.eventOccurred"></a>

### InsertIO.eventOccurred(event, [params], [success], [error])
Sends an event to Insert.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  

| Param | Type | Description |
| --- | --- | --- |
| event | <code>string</code> | - |
| [params] | <code>object</code> | user defined event parameters |
| [success] | <code>function</code> | called when the event was handed over to the native SDK |
| [error] | <code>function</code> | called when the event could not be handed over to the native SDK |

<a name="cordova.plugins.module_InsertIO.setUserAttributes"></a>

### InsertIO.setUserAttributes(attributes, [success], [error])
Set user attributes to tailor specific Inserts to users.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  
**Remarks**: You do not need to wrap your values into quotation marks as the article mentions.
**See**: [How to: Set custom events to be used as triggers & in audience](https://support.insert.io/hc/en-us/articles/115000140685-How-to-Set-custom-events-to-be-used-as-triggers-in-audience)  

| Param | Type | Description |
| --- | --- | --- |
| attributes | <code>object</code> | A string key - any value |
| [success] | <code>function</code> | called when the attributes were set |
| [error] | <code>function</code> | called when the attributes could not be set |

<a name="cordova.plugins.module_InsertIO.setUserId"></a>

### InsertIO.setUserId(userId, [success], [error])
Set a user id to tailor inserts to users.

**Kind**: static method of <code>[InsertIO](#cordova.plugins.module_InsertIO)</code>  
**See**: [How to: Use custom data when defining an Insert Audience](https://support.insert.io/hc/en-us/articles/207569209-How-to-Use-custom-data-when-defining-an-Insert-Audience)  

| Param | Type | Description |
| --- | --- | --- |
| userId | <code>string</code> | an application defined user id |
| [success] | <code>function</code> | called when the id was set |
| [error] | <code>function</code> | called when the id could not be set |
