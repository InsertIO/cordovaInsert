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
        try {
            if (action.equals("init")) {
                final String appKey = this.preferences.getString("insertappkey", null);
                final String companyName = this.preferences.getString("insertcompanyname", null);
                if (appKey == null || appKey.length() == 0) {
                    callbackContext.error("ANDROID_APP_KEY not set in config.xml");
                    return true;
                }
                if (companyName == null || companyName.length() == 0) {
                    callbackContext.error("COMPANY_NAME not set in config.xml");
                    return true;
                }

                Application application = (Application) cordova.getActivity().getApplicationContext();
                initSDK(application, appKey, companyName, new InsertPhasesCallbackInterface() {
                    @Override
                    public void onInitStarted() {
                    }

                    @Override
                    public void onInitComplete() {
                        callbackContext.success();
                    }

                    @Override
                    public void onInitFailed() {
                        callbackContext.error("Insert.IO init error. No further information was provided by the SDK :(");
                    }
                });
            } else if (action.equals("dismissVisibleInserts")) {
                dismissVisibleInserts();
            } else if (action.equals("eventOccurred")) {
                if (inputs.length() >= 2) {
                    cordova.getThreadPool().execute(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                eventOccurred(inputs.getString(0), valuesToString(inputs.getJSONObject(1)));
                                callbackContext.success()
                            } catch (JSONException e) {
                                callbackContext.error(e.getMessage());
                            }
                        }
                    });
                }
            } else if (action.equals("setUserAttributes")) {
                setUserAttributes(valuesToString(inputs.getJSONObject(0)));
                callbackContext.success()
            } else if (action.equals("setUserId")) {
                setUserId(inputs.getString(0));
                callbackContext.success()
            } else {
                return false; // will result in a MethodNotFound error
            }
            return true;
        } catch (e) {
            callbackContext.error(e.getMessage());
            return true;
        }
    }

    private static Map<String, String> valuesToString(JSONObject map) throws JSONException {
        final Map<String, String> result = new HashMap<String, String>(map.length());
        final Iterator<String> it = map.keys();
        while (it.hasNext()) {
            final String key = it.next();
            result.put(key, map.get(key).toString());
        }
        return result;
    }
}
