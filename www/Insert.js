/**
 * @module Insert
 * 
 */

function ensureStringValues(items) {
  return Object.keys(items).reduce(function(result, key) {
    result[key] = "\"" + items[key].toString() + "\"";
    return result;
  }, {});
}

/**
 * Handle insert-* URLs in iOS apps
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
   * 
   * @param {function} [success] - called when initialisation succeeded
   * @param {function} [error] - called when initialisation fails
   * @see Insert.setUserAttributes
   * @see Insert.setUserId
   */
  init: function(success, error) {
    cordova.exec(
      success,
      error,
      'Insert',
      'init',
      []
    );
  },

  /**
   * Hides all visible inserts.
   * 
   * Since inserts can carry private information you 
   * should call this function when your user logs out of you app.
   * 
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

  /**
   * Set a user id to tailor inserts to users.
   * 
   * @param {string} userId - an application defined user id
   * @param {function} [success] - called when the id was set
   * @param {function} [error] - called when the id could not be set
   * 
   * @see [How to: Use custom data when defining an Insert Audience](https://support.insert.io/hc/en-us/articles/207569209-How-to-Use-custom-data-when-defining-an-Insert-Audience)
   */
  setUserId: function(userId, success, error) {
    cordova.exec(
      success,
      error,
      "Insert",
      "setUserId",
      [userId]
    );
  }
};
