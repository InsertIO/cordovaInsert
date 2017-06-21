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
import static sdk.insert.io.Insert.setPushId;
import static sdk.insert.io.Insert.setUserAttributes;
import static sdk.insert.io.Insert.setUserId;

public class Insert extends CordovaPlugin {
	@Override
	public boolean execute(String action, JSONArray inputs, CallbackContext callbackContext) throws JSONException {
		if (action.equals("dismissVisibleInserts")) {
			dismissVisibleInserts();
		} else if (action.equals("setPushId")) {
			if (inputs.length() > 0) {
			setPushId(inputs.get(0).toString());
			}
		} else if (action.equals("setUserAttributes")) {
            setUserAttributes(toMap(inputs.getJSONObject(0)));
            callbackContext.success();
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
				final Map<String, String> finalMap = mapData;
				final JSONArray finalInputs = inputs;
				cordova.getThreadPool().execute(new Runnable() {
					@Override
					public void run() {
						try {
							eventOccurred(finalInputs.get(0).toString(), finalMap);
						} catch (JSONException e) {
							e.printStackTrace();
						}
					}
				});
			}
		} else if (action.equals("setUserId")) {
            setUserId(inputs.getString(0));
            callbackContext.success();
        }
        else {
		}
		return true;
	}

	private static Map<String, String> toMap(final JSONObject map) throws JSONException {
        final Map<String, String> result = new HashMap<String, String>(map.length());
        final Iterator<String> it = map.keys();
        while (it.hasNext()) {
            final String key = it.next();
            result.put(key, map.get(key).toString());
        }
        return result;
    }

}
