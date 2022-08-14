import 'package:flutter/material.dart';
import 'package:embedded_youtube_player/embedded_youtube_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final YouTubePlayerController _playerController = YouTubePlayerController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _playerController.play("HpfeCK4WpUY");
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 16/9,
              child: YouTubePlayer(
                controller: _playerController,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _playerController.play("v-Htpt-ZtcA");
          },
          child: Icon(
            Icons.ac_unit,
            size: 24,
          ),
        ),
      ),
    );
  }
}
