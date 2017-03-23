package io.insert.cordova.plugin;

import android.app.Application;
import android.content.Context;
import android.support.multidex.MultiDexApplication;
import android.support.multidex.MultiDex;

import sdk.insert.io.Insert;

public class InsertApplication extends MultiDexApplication {
  @Override
  protected void attachBaseContext(Context base) {
     super.attachBaseContext(base);
     MultiDex.install(this);
   }
}
