
var argscheck = require('cordova/argscheck');
var exec = require('cordova/exec');

var InsertExport = {};

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
