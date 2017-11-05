/**
 * @module cordova.plugins.InsertIO
 * 
 */

function ensureStringValues(items) {
  return Object.keys(items).reduce(function(result, key) {
    const value = items[key];
    if (value !== null && value !== undefined) {
      result[key] = value.toString();
    }
    return result;
  }, {});
}

/**
 * Handle insert-* URLs in iOS apps
 * 
 * @private
 */
var _handleOpenURL = window.handleOpenURL;
window.handleOpenURL = function(url) {
  if (url.indexOf("insert-") === 0) {
    cordova.exec(
      null,
      null,
      "Insert",
      "initWithUrl",
      [url]
    );
  } else {
    _handleOpenURL(url);
  }
};

module.exports = {

  /**
   * Initialise the native SDK.
   * 
   * You should call this as soon as possible in the app.
   * Probably before tearing down the splashscreen when you plan to serve
   * "App Start" triggered Inserts.
   * @param {object} userAttributes - A string key - any value
   * @param {string} visitorId - the visitor's id.
   * @param {string} accoundIt - the account's id.
   * @param {function} [success] - called when initialisation succeeded
   * @param {function} [error] - called when initialisation fails
   * @see Insert.setUserAttributes
   * @see Insert.setUserId
   */
  initSDK: function(userAttributes, visitorId, accountId, success, error) {
    cordova.exec(
      success,
      error,
      'Insert',
      'initSDK',
      [userAttributes, visitorId, accountId]
    );
  },

  /**
   * Hides all visible inserts.
   * 
   * Since inserts can carry private information you 
   * should call this function when your user logs out of you app.
   * @param {function} [success]
   * @param {function} [error]
   */
  dismissVisibleInserts: function(success, error) {
    cordova.exec(
        success,
        error,
        'Insert',
        'dismissVisibleInserts',
        []
    );
  },

  /**
   * Sends an event to Insert.
   * 
   * You have to register events first in your Insert dashboard.
   * Sending unregistered events has no effect. 
   * 
   * @param {string} event - 
   * @param {object} [params] - user defined event parameters
   * @param {function} [success] - called when the event was handed over to the native SDK
   * @param {function} [error] - called when the event could not be handed over to the native SDK
   */
  eventOccurred: function(event, params, success, error) {
    cordova.exec(
      success,
      error,
      'Insert',
      'eventOccurred',
      [event, params]
    );
  },

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
  setUserAttributes: function(attributes, success, error) {
    cordova.exec(
      success,
      error,
      "Insert",
      "setUserAttributes",
      [ensureStringValues(attributes)]
    );
  },

  setPushId: function(pushId, success, error) {
    if (typeof pushId === 'string'){
      cordova.exec(
          success,
          error,
          'Insert',
          'setPushId',
          [pushId]
      );
     } else {
       if (typeof error === 'function') {
         error('type missmatch: pushId should be of type string')
       }
    }
  }
};
