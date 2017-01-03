package com.cordova.insert.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import static sdk.insert.io.Insert.dismissVisibleInserts;
import static sdk.insert.io.Insert.eventOccurred;

public class Insert extends CordovaPlugin {
	@Override
	public boolean execute(String action, JSONArray inputs, CallbackContext callbackContext) throws JSONException {
		if (action.equals("dismissVisibleInserts")) {
			dismissVisibleInserts();
		} else if (action.equals("eventOccurred")) {
			if (inputs.length() >= 2) {
			    Map<String, String> mapData = new HashMap<String, String>();
			    JSONObject jsonObject = (JSONObject) inputs.get(1);
			    Iterator<String> keysItr = jsonObject.keys();
			        while(keysItr.hasNext()) {
			            String key = keysItr.next();
			            String value = jsonObject.get(key).toString();
			            mapData.put(key, value);
			        }
				eventOccurred(inputs.get(0).toString(), mapData);
			}
		} else {
		}
		return true;
	}
}