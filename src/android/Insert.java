package com.cordova.insert.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import static sdk.insert.io.Insert.dismissVisibleInserts;

public class Insert extends CordovaPlugin {
	@Override
	public boolean execute(String action, JSONArray inputs, CallbackContext callbackContext) throws JSONException {
		switch (action) {
			case "dismissVisibleInserts":
				dismissVisibleInserts();
				break;
			case "eventOccured":
				// eventOccured(inputs.getString(0), inputs.getJSONObject(0));
				break;
			default:
				break;
		}
		return true;
	}
}