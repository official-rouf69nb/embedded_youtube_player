// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:embedded_youtube_player/embedded_youtube_player_method_channel.dart';
//
// void main() {
//   MethodChannelEmbeddedYoutubePlayer platform = MethodChannelEmbeddedYoutubePlayer();
//   const MethodChannel channel = MethodChannel('embedded_youtube_player');
//
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   setUp(() {
//     channel.setMockMethodCallHandler((MethodCall methodCall) async {
//       return '42';
//     });
//   });
//
//   tearDown(() {
//     channel.setMockMethodCallHandler(null);
//   });
//
//   test('getPlatformVersion', () async {
//     expect(await platform.getPlatformVersion(), '42');
//   });
// }
