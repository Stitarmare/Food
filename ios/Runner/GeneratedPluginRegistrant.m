//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<drawerbehavior/DrawerbehaviorPlugin.h>)
#import <drawerbehavior/DrawerbehaviorPlugin.h>
#else
@import drawerbehavior;
#endif

#if __has_include(<shared_preferences/SharedPreferencesPlugin.h>)
#import <shared_preferences/SharedPreferencesPlugin.h>
#else
@import shared_preferences;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [DrawerbehaviorPlugin registerWithRegistrar:[registry registrarForPlugin:@"DrawerbehaviorPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
}

@end
