import 'package:flutter/material.dart';
import 'package:miniproject/const/colors.dart';

class DetailScreen extends StatelessWidget {
  final String content; // 내용
  final String date;    // 날짜
  final String reserveTime; // 예약시간
  final String locationtext; // 장소 이름
  final String distance; // 떨어진 거리
  final String transportation; // 이동 수단
  final String type; // 학교/회사/개인약속


  DetailScreen({
    required this.content,
    required this.date,
    required this.reserveTime,
    required this.locationtext,
    required this.distance,
    required this.transportation,
    required this.type,

  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // 추가 부분
        title: Text('일정 확인'),
        backgroundColor: Colors.tealAccent,
      ),

      body: SafeArea(
          top: true,
          child:
          Container(
            color: primaryColor2,

            child: Column(
              // 위, 아래 끝에 위젯 각각을 배치
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // 반대 축 최대 크기로 늘리기
              //crossAxisAlignment: CrossAxisAlignment.stretch,

              //detail_screen 위에 (상단에 1. 이미지 2. 설정 목록 배치)
              children: [ // 화면에 위는 _이미지, 아래는 _설정 목록 위젯 띄우기
                const SizedBox(height: 10.0),
                _DateImage(type:type),
                const SizedBox(height: 10.0),
                _DDayContent(
                  date: '$date',
                  time: '$reserveTime',
                  locationtext: '$locationtext',
                  distance: '$distance',
                  transportation: '$transportation',
                  contents: '$content', // 띄어쓰기포함 최대 15자
                  //alarm: '10분 전',
                ),
                const SizedBox(height: 10.0),
              ],

            ),
          )
      ),
    );

  }
}


// 위젯1. 일정에서 등록한 이미지
class _DateImage extends StatelessWidget {
  final String type;

  _DateImage({required this.type});

  @override
  Widget build(BuildContext context) {
    String image;
    switch (type) {
      case 'Type.school':
        image = 'asset/img/school.jpg';
        break;
      case 'Type.company':
        image = 'asset/img/company.jpg';
        break;
      case 'Type.friend':
        image = 'asset/img/friend.jpg';
        break;
      default:
        image = '';
        break;
    }
    return Expanded(
      child: Center(
        child: Container(
          width: 380, // 흰색 둥근 네모 너비
          decoration: BoxDecoration(
            color: Colors.grey[200], // 회색 배경(임시)
            borderRadius: BorderRadius.circular(30.0), // 모서리 둥글게
            image: DecorationImage(
              image: AssetImage(image), // 이미지 경로
              fit: BoxFit.cover, // 이미지가 화면에 맞게 크기를 조정
            ),
          ),
          padding: EdgeInsets.all(10.0), // 내부 패딩
        ),
      ),
    );
  }
}
// 위젯 2.
class _DDayContent extends StatelessWidget {
  final String date;            // 날짜
  final String time;            // 시간
  final String locationtext;        // 장소
  final String distance;        // 거리
  final String transportation;  // 이동 수단
  final String  contents;       // 내용
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
          const SizedBox(height: 20.0),
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
                transportation == 'Transportation.car' ? '자동차' : '도보',
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