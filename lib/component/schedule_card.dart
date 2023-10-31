import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/const/colors.dart';

//  전체 위젯 보여주는 스케줄카드
class ScheduleCard extends StatelessWidget {
  final String content;
  final String date;
  //final int reserveTime;
  final DateTime firstDay;
  final String type; // 학교/회사/개인약속
  //String image ='';

  const ScheduleCard({
    required this.content,
    required this.date,
    //required this.reserveTime,
    required this.firstDay,
    required this.type,
    Key? key,
  }) : super(key: key);

  String get image {
    switch (type) {
      case 'Type.school':
        return 'asset/img/school1.jpg';
      case 'Type.company':
        return 'asset/img/company1.jpg';
      case 'Type.friend':
        return 'asset/img/friend1.jpg';
      default:
        return ''; // 예외 처리를 위한 기본값
    }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Container(
        margin: EdgeInsets.only(top: 16.0),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1.0,
            color: Colors.black, // 테두리의 색상을 지정 (예: 검정색)
          ),
          image: DecorationImage(
            image: AssetImage(image), // 이미지 경로
            fit: BoxFit.cover, // 이미지가 화면에 맞게 크기를 조정
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: IntrinsicHeight(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 왼쪽에 하나, 가운데에 하나 배치
                          children: [
                            _Date(date: date),
                            Container(),
                            _DDay(firstDay: firstDay),
                            Container(),

                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            _Content(content: content)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
class _DDay extends StatelessWidget {
  final DateTime firstDay;

  _DDay({
    required this.firstDay, // 날짜 변수로 입력받기 (여기는 생성자. 외부(홈스태이트)에서 입력 받도록 정의
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now(); // 현재 날짜 시간

    return Container(
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

class _Date extends StatelessWidget {
  final String date;

  const _Date({
    required this.date,
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: primaryColor2,
      fontSize: 32.0,
    );

    return Text(
      '${date.toString()}',
      style: textStyle,
    );
  }
}


// 예약 내용 보여줄 위젯
class _Content extends StatelessWidget {
  final String content;

  const _Content({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(content,style: TextStyle(
      fontSize: 24,
    ),),);
  }
}


