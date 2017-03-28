<a name="module_Insert"></a>

## Insert

* [Insert](#module_Insert)
    * _static_
        * [.init([success], [error])](#module_Insert.init)
        * [.dismissVisibleInserts([success], [error])](#module_Insert.dismissVisibleInserts)
        * [.eventOccurred(event, [params], [success], [error])](#module_Insert.eventOccurred)
        * [.setUserAttributes(attributes, [success], [error])](#module_Insert.setUserAttributes)
        * [.setUserId(userId, [success], [error])](#module_Insert.setUserId)
    * _inner_
        * [~_handleOpenURL](#module_Insert.._handleOpenURL)

<a name="module_Insert.init"></a>

### Insert.init([success], [error])
Initialise the native SDK.

You should call this as soon as possible in the app.
Probably before tearing down the splashscreen when you plan to serve
"App Start" triggered Inserts.

**Kind**: static method of <code>[Insert](#module_Insert)</code>  
**See**

- Insert.setUserAttributes
- Insert.setUserId


| Param | Type | Description |
| --- | --- | --- |
| [success] | <code>function</code> | called when initialisation succeeded |
| [error] | <code>function</code> | called when initialisation fails |

<a name="module_Insert.dismissVisibleInserts"></a>

### Insert.dismissVisibleInserts([success], [error])
Hides all visible inserts.

Since inserts can carry private information you 
should call this function when your user logs out of you app.

**Kind**: static method of <code>[Insert](#module_Insert)</code>  

| Param | Type |
| --- | --- |
| [success] | <code>function</code> | 
| [error] | <code>function</code> | 

<a name="module_Insert.eventOccurred"></a>

### Insert.eventOccurred(event, [params], [success], [error])
Sends an event to Insert.

You have to register events first in your Insert dashboard.
Sending unregistered events has no effect.

**Kind**: static method of <code>[Insert](#module_Insert)</code>  

| Param | Type | Description |
| --- | --- | --- |
| event | <code>string</code> | - |
| [params] | <code>object</code> | user defined event parameters |
| [success] | <code>function</code> | called when the event was handed over to the native SDK |
| [error] | <code>function</code> | called when the event could not be handed over to the native SDK |

<a name="module_Insert.setUserAttributes"></a>

### Insert.setUserAttributes(attributes, [success], [error])
Set user attributes to tailor specific Inserts to users.

**Kind**: static method of <code>[Insert](#module_Insert)</code>  
**Remarks**: You do not need to wrap your values into quotation marks as the article mentions.
The cordova plugin is taking care of that for you.  
**See**: [How to: Set custom events to be used as triggers & in audience](https://support.insert.io/hc/en-us/articles/115000140685-How-to-Set-custom-events-to-be-used-as-triggers-in-audience)  

| Param | Type | Description |
| --- | --- | --- |
| attributes | <code>object</code> | A string key - any value |
| [success] | <code>function</code> | called when the attributes were set |
| [error] | <code>function</code> | called when the attributes could not be set |

<a name="module_Insert.setUserId"></a>

### Insert.setUserId(userId, [success], [error])
Set a user id to tailor inserts to users.

**Kind**: static method of <code>[Insert](#module_Insert)</code>  
**See**: [How to: Use custom data when defining an Insert Audience](https://support.insert.io/hc/en-us/articles/207569209-How-to-Use-custom-data-when-defining-an-Insert-Audience)  

| Param | Type | Description |
| --- | --- | --- |
| userId | <code>string</code> | an application defined user id |
| [success] | <code>function</code> | called when the id was set |
| [error] | <code>function</code> | called when the id could not be set |

<a name="module_Insert.._handleOpenURL"></a>

### Insert~_handleOpenURL
Handle insert-* URLs in iOS apps

**Kind**: inner property of <code>[Insert](#module_Insert)</code>  
