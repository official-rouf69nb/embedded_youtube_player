import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YouTubePlayer extends StatefulWidget {
  final YouTubePlayerController controller;
  const YouTubePlayer({Key? key, required this.controller}) : super(key: key);

  @override
  State<YouTubePlayer> createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  final String viewType = 'com.codepoka.embedded_youtube_player';
  Map<String, dynamic> creationParams = {"video_id": "",};

  @override
  initState(){
    widget.controller._playEventHandler = _onPlayNewVideo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, sizeConstraints){
              switch (defaultTargetPlatform) {
                case TargetPlatform.android:
                  return AndroidView(
                    key: widget.controller._playerKey,
                    viewType: viewType,
                    layoutDirection: TextDirection.ltr,
                    creationParams: creationParams,
                    creationParamsCodec: const StandardMessageCodec(),
                    onPlatformViewCreated: _onViewCreated,
                  );
                case TargetPlatform.iOS:
                  return UiKitView(
                    key: widget.controller._playerKey,
                    viewType: viewType,
                    layoutDirection: TextDirection.ltr,
                    creationParams: creationParams,
                    creationParamsCodec: const StandardMessageCodec(),
                    onPlatformViewCreated: _onViewCreated,
                  );
                default:
                  throw UnsupportedError('Unsupported platform view');
              }
            },
          ),
          if(!widget.controller._isInitialized)
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: Colors.black,
              child: const Center(
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onPlayNewVideo(String videoID) {
    if(videoID.isEmpty){
      throw Exception("YouTube video id could not be empty!");
    }
    if(mounted){
      setState((){
        widget.controller._playerKey = GlobalKey();
        widget.controller._isInitialized = false;
        creationParams = {
          "video_id": videoID,
        };
      });
    }
  }

  void _onViewCreated(int id) {
    if(mounted){
      setState((){
        widget.controller._isInitialized = true;
      });
    }
  }
}

class YouTubePlayerController{
  void Function(String url)? _playEventHandler;
  GlobalKey? _playerKey;
  bool _isInitialized = false;
  void play(String url){
    _playEventHandler?.call(url);
  }
}