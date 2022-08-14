#import "EmbeddedYoutubePlayerPlugin.h"
#if __has_include(<embedded_youtube_player/embedded_youtube_player-Swift.h>)
#import <embedded_youtube_player/embedded_youtube_player-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "embedded_youtube_player-Swift.h"
#endif

@implementation EmbeddedYoutubePlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEmbeddedYoutubePlayerPlugin registerWithRegistrar:registrar];
}
@end
