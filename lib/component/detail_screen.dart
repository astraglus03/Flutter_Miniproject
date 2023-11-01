import 'package:flutter/material.dart';
import 'package:miniproject/const/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class DetailScreen extends StatelessWidget {
  final String content; // 내용
  final String date; // 날짜
  final String reserveTime; // 예약시간
  final String locationtext; // 장소 이름
  final String distance; // 떨어진 거리
  final String transportation; // 이동 수단
  final String type; // 학교/회사/개인약속
  final DateTime firstDay;

  DetailScreen({
    required this.content,
    required this.date,
    required this.reserveTime,
    required this.locationtext,
    required this.distance,
    required this.transportation,
    required this.type,
    required this.firstDay,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 추가 부분
        title: Text('일정 확인'),
        backgroundColor: Colors.tealAccent,
      ),
      body: SafeArea(
          top: true,
          child: Container(
            color: primaryColor2,
            child: Column(
              // 위, 아래 끝에 위젯 각각을 배치
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // 반대 축 최대 크기로 늘리기
              //crossAxisAlignment: CrossAxisAlignment.stretch,

              //detail_screen 위에 (상단에 1. 이미지 2. 설정 목록 배치)
              children: [
                // 화면에 위는 _이미지, 아래는 _설정 목록 위젯 띄우기
                _DDay(firstDay: firstDay),
                _DateImage(type: type),
                const SizedBox(height: 10.0),
                _DDayContent(
                  date: '$date',
                  time: '$reserveTime',
                  locationtext: '$locationtext',
                  distance: '$distance',
                  transportation: '$transportation',
                  contents: '$content', // 띄어쓰기포함 최대 15자
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          )),
    );
  }
}

class _DateImage extends StatefulWidget {
  final String type;

  const _DateImage({required this.type});

  @override
  _DateImageState createState() => _DateImageState();
}

class _DateImageState extends State<_DateImage> {
  String largeImage = '';
  String selectedVideoPath = '';
  bool _isVideoVisible = false;

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case 'Type.school':
        largeImage = 'asset/img/school1.jpg';
        break;
      case 'Type.company':
        largeImage = 'asset/img/company1.jpg';
        break;
      case 'Type.friend':
        largeImage = 'asset/img/friend1.jpg';
        break;
      default:
        largeImage = 'image1'; // 기본값
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String image1;
    String image2;
    String image3;
    String videoPath;

    switch (widget.type) {
      case 'Type.school':
        image1 = 'asset/img/school1.jpg';
        image2 = 'asset/img/school2.jpg';
        image3 = 'asset/img/school3.jpg';
        videoPath = "asset/school.mp4";
        break;
      case 'Type.company':
        image1 = 'asset/img/company1.jpg';
        image2 = 'asset/img/company2.jpg';
        image3 = 'asset/img/company3.jpg';
        videoPath = "asset/company.mp4";
        break;
      case 'Type.friend':
        image1 = 'asset/img/friend1.jpg';
        image2 = 'asset/img/friend2.jpg';
        image3 = 'asset/img/friend3.jpg';
        videoPath = "asset/friend.mp4";
        break;
      default:
        image1 = '';
        image2 = '';
        image3 = '';
        videoPath = '';
        break;
    }

    void selectImage(String imageName) {
      setState(() {
        largeImage = imageName;
        selectedVideoPath = '';
      });
    }

    void showVideo() {
      setState(() {
        selectedVideoPath = widget.type == 'Type.school'
            ? "asset/school.mp4"
            : widget.type == 'Type.company'
                ? "asset/company.mp4"
                : "asset/friend.mp4";
      });
    }

    return Expanded(
      child: Center(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  showVideo();
                },
                child: selectedVideoPath.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            image: AssetImage(largeImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : _VideoContainer(videoPath: selectedVideoPath),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        selectImage(image1);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            image: AssetImage(image1),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        selectImage(image2);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            image: AssetImage(image2),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        selectImage(image3);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            image: AssetImage(image3),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showVideo();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            image: AssetImage(image3),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoContainer extends StatefulWidget {
  final String videoPath;

  const _VideoContainer({required this.videoPath});

  @override
  _VideoContainerState createState() => _VideoContainerState();
}

class _VideoContainerState extends State<_VideoContainer> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.asset(widget.videoPath),
      autoPlay: true,
      looping: true,
      // 다른 설정 옵션들도 추가할 수 있습니다.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }
}

// 위젯 2.
class _DDayContent extends StatelessWidget {
  final String date; // 날짜
  final String time; // 시간
  final String locationtext; // 장소
  final String distance; // 거리
  final String transportation; // 이동 수단
  final String contents; // 내용
  //final String alarm;           // 알림

  _DDayContent({
    required this.date,
    required this.time,
    required this.locationtext,
    required this.distance,
    required this.transportation,
    required this.contents,
    //required this.alarm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      decoration: BoxDecoration(
        color: Colors.grey[200], // 회색 배경(임시)
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  '날짜: ',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 25.0,
                  color: primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  '시간: ',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 25.0,
                  color: primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  '장소: ',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                locationtext,
                style: TextStyle(
                  fontSize: 25.0,
                  color: primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  '떨어진 거리(km): ',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                double.parse(distance).round().toString(), // 떨어진 거리 반올림
                style: TextStyle(
                  fontSize: 25.0,
                  color: primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  '이동 수단: ',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                transportation == 'Transportation.car' ? '자가용' : '도보',
                style: TextStyle(
                  fontSize: 25.0,
                  color: primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  '내용: ',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                contents,
                style: TextStyle(
                  fontSize: 25.0,
                  color: primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

// 위젯 2.
class _DDay extends StatelessWidget {
  final DateTime firstDay;

  _DDay({
    required this.firstDay,
    //required this.alarm,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // 회색 배경(임시)
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: EdgeInsets.all(10.0),
      child: Text(
        // 만난 후 D-Day 계산하기
            () {
          final difference = DateTime(now.year, now.month, now.day).difference(firstDay).inDays;
          if (difference == 0) {
            return 'D-Day';
          } else if (difference > 0) {
            return 'D+${difference}';
          } else {
            return 'D${difference}';
          }
        }(),
        style: TextStyle(
          fontSize: 32,
          color: primaryColor2,
        ),
      ),
    );
  }
}
