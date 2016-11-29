
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

InsertExport.eventOccured = function(event, paramsObject, successCallback, failureCallback) {
  if (typeof event === 'string' && typeof paramsObject === 'object'){
    cordova.exec(
      successCallback,
      failureCallback,
      'Insert',
      'eventOccured',
      [event, paramsObject]
    );
  } else {
    if (typeof failureCallback === 'function'){
      failureCallback('type missmatch: event should be of type string and paramsObject shold be an object')
    }
  }
}

module.exports = InsertExport;
