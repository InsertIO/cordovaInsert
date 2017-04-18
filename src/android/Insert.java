package io.insert.cordova.plugin;

import android.app.Application;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import sdk.insert.io.InsertPhasesCallbackInterface;

import static sdk.insert.io.Insert.initSDK;
import static sdk.insert.io.Insert.dismissVisibleInserts;
import static sdk.insert.io.Insert.eventOccurred;
import static sdk.insert.io.Insert.setUserAttributes;
import static sdk.insert.io.Insert.setUserId;

public class Insert extends CordovaPlugin {
    @Override
    public boolean execute(String action, final JSONArray inputs, final CallbackContext callbackContext) throws JSONException {
        if (action.equals("init")) {
            final String companyName = this.preferences.getString("insertcompanyname", "");
            if (companyName.length() == 0) {
                callbackContext.error("COMPANY_NAME not set in config.xml");
                return true;
            }

            final String appKey = this.preferences.getString("insertappkey", "");
            if (appKey.length() == 0) {
                callbackContext.error("ANDROID_APP_KEY not set in config.xml");
                return true;
            }
            
            final Application application = (Application) cordova.getActivity().getApplicationContext();
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    InsertOptions.Builder insertOptionsBuilder = new InsertOptions.Builder();
                    insertOptionsBuilder.addIgnoreFirstOnCreate(true);
                    insertOptionsBuilder.setStrictMode(true);

                    initSDK(application, appKey, companyName, insertOptionsBuilder.build(), null);
                }
            });
        } else if (action.equals("dismissVisibleInserts")) {
            dismissVisibleInserts();
            callbackContext.success();
        } else if (action.equals("eventOccurred")) {
            if (inputs.length() >= 2) {
                cordova.getThreadPool().execute(new Runnable() {
                    @Override
                    public void run() {
                        try {
                            eventOccurred(inputs.getString(0), toMap(inputs.getJSONObject(1)));
                            callbackContext.success();
                        } catch (JSONException e) {
                            callbackContext.error(e.getMessage());
                        }
                    }
                });
            }
        } else if (action.equals("setUserAttributes")) {
            setUserAttributes(toMap(inputs.getJSONObject(0)));
            callbackContext.success();
        } else if (action.equals("setUserId")) {
            setUserId(inputs.getString(0));
            callbackContext.success();
        } else {
            return false; // will result in a MethodNotFound error
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
