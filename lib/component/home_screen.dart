import 'package:flutter/material.dart';
import 'package:miniproject/component/add_schedule.dart';
import 'package:miniproject/component/schedule_card.dart';
import 'package:miniproject/const/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 띄워져있는 +버튼
      floatingActionButton:FloatingActionButton(
        backgroundColor: primaryColor2,
        onPressed: (){// 버튼 눌렀을때 화면 띄우기 //네비게이터를 이용해서 새롭게 빌드
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSchedule()),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: ListView(
      children: [
        ScheduleCard(content: "안녕하세요 저는 배재민입니다", reserveTime: 10),
        ScheduleCard(content: "안녕하세요 저는 김건동입니다", reserveTime: 12),
        ScheduleCard(content: "안녕하세요 저는 심종혜입니다", reserveTime: 14),
        ScheduleCard(content: "안녕하세요 저는 멍청이입니다", reserveTime: 18),
        ScheduleCard(content: "안녕하세요 저는 알라딘입니다", reserveTime: 20),
        ScheduleCard(content: "안녕하세요 저는 왕한호입니다", reserveTime: 22),
        ScheduleCard(content: "안녕하세요 저는 정승도입니다", reserveTime: 24),
        ScheduleCard(content: "안녕하세요 저는 배재민입니다", reserveTime: 10),
        ScheduleCard(content: "안녕하세요 저는 김건동입니다", reserveTime: 12),
        ScheduleCard(content: "안녕하세요 저는 심종혜입니다", reserveTime: 14),
        ScheduleCard(content: "안녕하세요 저는 멍청이입니다", reserveTime: 18),
        ScheduleCard(content: "안녕하세요 저는 알라딘입니다", reserveTime: 20),
        ScheduleCard(content: "안녕하세요 저는 왕한호입니다", reserveTime: 22),
        ScheduleCard(content: "안녕하세요 저는 정승도입니다", reserveTime: 24),
      ],
      ),
    );
  }
}
