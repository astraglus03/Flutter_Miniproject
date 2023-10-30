import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String video;

  const CustomVideoPlayer({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController; // 비디오 컨트롤러 말고 이거 사용

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.video);
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("고양이 동영상"),
      ),
      body: Center(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
