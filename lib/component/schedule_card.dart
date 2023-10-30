import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/const/colors.dart';

//  전체 위젯 보여주는 스케줄카드
class ScheduleCard extends StatelessWidget {
  final String content;
  final int reserveTime;
  const ScheduleCard({
    required this. content,
    required this.reserveTime,
    Key?key,
}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: Colors.black, // 테두리의 색상을 지정 (예: 검정색)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(
                reserveTime: reserveTime,
              ),
              SizedBox(width: 20.0,),
              _Content(content: content,),
              SizedBox(width: 16.0,),
            ],
          ),
        ),
      ),
      ),
    );
  }
}


//  예약시간 표시하기위한 위젯
class _Time extends StatelessWidget{
  final int reserveTime;

  const _Time({
    required this.reserveTime,
    Key?key,
}):super(key:key);

  Widget build(BuildContext context){
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: primaryColor2,
      fontSize: 28.0,
    );

    return Text('${reserveTime.toString().padLeft(2,'0')}:00',style: textStyle,);
    // ${startTime.toString().padLeft(2,'0')}:00,
    // style:textstyle,
  }
}

// 예약 내용 보여줄 위젯
class _Content extends StatelessWidget {
  final String content;
  const _Content({
    required this.content,
    Key?key,
}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(content));
  }
}

