package com.cordova.insert.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import static sdk.insert.io.Insert.dismissVisibleInserts;
import static sdk.insert.io.Insert.eventOccurred;

public class Insert extends CordovaPlugin {
	@Override
	public boolean execute(String action, JSONArray inputs, CallbackContext callbackContext) throws JSONException {
		switch (action) {
			case "dismissVisibleInserts":
				dismissVisibleInserts();
				break;
			case "eventOccurred":
				eventOccurred("customEvent", null);
				break;
			default:
				break;
		}
		return true;
	}
}