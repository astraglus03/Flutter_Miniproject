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
    return Container(
      child: Center(
        child: _context(
          onTap: () {
            selectVideo(context);
          },
          video: video,
        ),
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
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1.0,
            color: Colors.black,
          ),
          image: DecorationImage(
            image: AssetImage('asset/img/friend.jpg'), // 배경 이미지 경로
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: IntrinsicHeight(
            child: Center(
              child: Column( // Expanded 위젯을 Column으로 변경
                children: [
                  if (video != null) Expanded(child: Text("시연 동영상 ", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.tealAccent,
                  ),)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
