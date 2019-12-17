package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.infideap.drawerbehavior.DrawerbehaviorPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    DrawerbehaviorPlugin.registerWith(registry.registrarFor("com.infideap.drawerbehavior.DrawerbehaviorPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
