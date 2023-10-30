import 'package:flutter/material.dart';
import 'package:miniproject/const/colors.dart';

class DetailScreen extends StatelessWidget {
  final String content;
  final int reserveTime;
  // 생성자 (home_screen.dart에서 받아옴) +) 터치했을 때 화면 넘어가기 위해
  DetailScreen({required this.content, required this.reserveTime});
  
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
                _DateImage(),
                const SizedBox(height: 10.0),
                _DDayContent(
                  date: '2023-10-30',
                  time: '15:30',
                  location: '공원',
                  distance: '10km',
                  transportation: '도보',
                  contents: '공원 쓰레기 수거 자원봉사', // 띄어쓰기포함 최대 15자
                  alarm: '10분 전',
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          width: 380, // 흰색 둥근 네모 너비
          decoration: BoxDecoration(
            color: Colors.grey[200], // 회색 배경(임시)
            borderRadius: BorderRadius.circular(30.0), // 모서리 둥글게
          ),
          padding: EdgeInsets.all(10.0), // 내부 패딩
          child: Image.asset(
            'asset/img/cat5.png',
            height: MediaQuery.of(context).size.height / 3, // 화면의 1/3 차지하게..?
          ),
        ),
      ),
    );
  }
}
// 위젯 2.
class _DDayContent extends StatelessWidget {
  final String date;            // 날짜
  final String time;            // 시간
  final String location;        // 장소
  final String distance;        // 거리
  final String transportation;  // 이동 수단
  final String  contents;       // 내용
  final String alarm;           // 알림

  _DDayContent({
    required this.date,
    required this.time,
    required this.location,
    required this.distance,
    required this.transportation,
    required this.contents,
    required this.alarm,
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
                location,
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
                distance,
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
                transportation,
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
          Row(
            children: [
              Expanded(
                child: Text(
                  '알림: ',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                alarm,
                style: TextStyle(
                  fontSize: 25.0,
                  color: primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

        ],
      ),

    );
  }
}

/*
// 위젯 2 설정 (이름) : 날짜, 시간, 장소 등등
class _DDayList extends StatelessWidget {
  final String setName; // 날짜, 시간 등 들어갈 이름

  const _DDayList({
    required this.setName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Text(
          setName,
        ),
    );
  }
}

// 위젯 3. 설정 내용 (db에서 가져오는 내용)
class _DDayContent extends StatelessWidget {
  final String date; // 날짜 정보를 받아올 변수
  final String time; // 시간
  final String location; // 장소
  final String distance; // 거리
  final String transportation; // 이동수단
  final String contents; // 내용
  final String alarm; // 알림

  _DDayContent({ // 초기화
    required this.date,
    required this.time,
    required this.location,
    required this.distance,
    required this.transportation,
    required this.contents,
    required this.alarm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );

    return Text(
      date,
    );
  }
}

*/

/*
// 위젯2. 설정 목록
class _DDayContent extends StatelessWidget {
  final String date; // 날짜 정보를 받아올 변수
  final String time; // 시간
  final String location; // 장소
  final String distance; // 거리
  final String transportation; // 이동수단
  final String contents; // 내용
  final String alarm; // 알림

  _DDayContent({ // 초기화
    required this.date,
    required this.time,
    required this.location,
    required this.distance,
    required this.transportation,
    required this.contents,
    required this.alarm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380, // 너비를 360으로 고정
      decoration: BoxDecoration(
        color: Colors.grey[200], // 회색 배경(임시)
        borderRadius: BorderRadius.circular(30.0), // 모서리 둥글게
      ),
      padding: EdgeInsets.all(10.0), // 내부 패딩
      child:Column(
        children: [
          const SizedBox(height: 20.0),
          Text(
            '날짜: ',
            // 글자에 스타일 적용
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            '시간: ',
            // 글자에 스타일 적용
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            '장소: ',
            // 글자에 스타일 적용
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
              '떨어진 거리(KM): ',
            // 글자에 스타일 적용
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
              '이동 수단: ',
            // 글자에 스타일 적용
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
                color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
              '내용: ',
            // 글자에 스타일 적용
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
              '알림: ',
            // 글자에 스타일 적용
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
       ],
      ),
    );
  }
}

*/