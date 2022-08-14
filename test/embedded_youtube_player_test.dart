// import 'package:flutter_test/flutter_test.dart';
// import 'package:embedded_youtube_player/embedded_youtube_player.dart';
// import 'package:embedded_youtube_player/embedded_youtube_player_platform_interface.dart';
// import 'package:embedded_youtube_player/embedded_youtube_player_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockEmbeddedYoutubePlayerPlatform
//     with MockPlatformInterfaceMixin
//     implements EmbeddedYoutubePlayerPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final EmbeddedYoutubePlayerPlatform initialPlatform = EmbeddedYoutubePlayerPlatform.instance;
//
//   test('$MethodChannelEmbeddedYoutubePlayer is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelEmbeddedYoutubePlayer>());
//   });
//
//   test('getPlatformVersion', () async {
//     EmbeddedYoutubePlayer embeddedYoutubePlayerPlugin = EmbeddedYoutubePlayer();
//     MockEmbeddedYoutubePlayerPlatform fakePlatform = MockEmbeddedYoutubePlayerPlatform();
//     EmbeddedYoutubePlayerPlatform.instance = fakePlatform;
//
//     expect(await embeddedYoutubePlayerPlugin.getPlatformVersion(), '42');
//   });
// }
