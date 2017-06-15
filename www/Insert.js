
var argscheck = require('cordova/argscheck');
var exec = require('cordova/exec');

var InsertExport = {};

function ensureStringValues(items) {
  return Object.keys(items).reduce(function(result, key) {
    const value = items[key];
    if (value !== null && value !== undefined) {
      result[key] = value.toString();
    }
    return result;
  }, {});
}

InsertExport.dismissVisibleInserts = function(successCallback, failureCallback) {
        cordova.exec(
            successCallback,
            failureCallback,
            'Insert',
            'dismissVisibleInserts',
            []
        );
}

InsertExport.setPushId = function(pushId, successCallback, failureCallback) {
        if (typeof pushId === 'string'){
        cordova.exec(
            successCallback,
            failureCallback,
            'Insert',
            'setPushId',
            [pushId]
        );
       } else {
         if (typeof failureCallback === 'function'){
           failureCallback('type missmatch: pushId should be of type string')
         }
       }
}

  /**
   * Set user attributes to tailor specific Inserts to users.
   * 
   * @param {object} attributes - A string key - any value
   * @param {function} [success] - called when the attributes were set
   * @param {function} [error] - called when the attributes could not be set
   * 
   * @see [How to: Set custom events to be used as triggers & in audience](https://support.insert.io/hc/en-us/articles/115000140685-How-to-Set-custom-events-to-be-used-as-triggers-in-audience)
   * @remarks You do not need to wrap your values into quotation marks as the article mentions.
   * The cordova plugin is taking care of that for you.
   */
InsertExport.setUserAttributes = function(attributes, success, error) {
    cordova.exec(
      success,
      error,
      "Insert",
      "setUserAttributes",
      [ensureStringValues(attributes)]
    );
  }

InsertExport.eventOccurred = function(event, paramsObject, successCallback, failureCallback) {
  if (typeof event === 'string' && typeof paramsObject === 'object'){
    cordova.exec(
      successCallback,
      failureCallback,
      'Insert',
      'eventOccurred',
      [event, paramsObject]
    );
  } else {
    if (typeof failureCallback === 'function'){
      failureCallback('type missmatch: event should be of type string and paramsObject should be an object')
    }
  }
}

module.exports = InsertExport;
