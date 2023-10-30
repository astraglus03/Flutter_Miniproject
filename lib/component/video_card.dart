import 'package:flutter/material.dart';
import 'package:miniproject/component/custom_video_player.dart';

class VideoCard extends StatelessWidget {
  final String video;

  const VideoCard({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _context(
        onTap: () {
          selectVideo(context);
        },
        video: video,
      ),
    );
  }

  void selectVideo(BuildContext context) {
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CustomVideoPlayer(video: video),
        ),
      );
    }
  }
}

class _context extends StatelessWidget {
  final GestureTapCallback onTap;
  final String video;

  const _context({
    required this.onTap,
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1.0,
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: IntrinsicHeight(
            child: Center(
              child: Column( // Expanded 위젯을 Column으로 변경
                children: [
                  if (video != null) Expanded(child: Text(video)), // 동적으로 비디오 파일 이름 표시
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
