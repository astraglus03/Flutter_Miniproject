import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/component/home_screen.dart';
import 'package:miniproject/component/schedule_card.dart';
import 'package:miniproject/component/video_card.dart';

import '../const/colors.dart';
import 'add_schedule.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key})
      : super(key: key); // 생성자 생성 전달 인자가 없어서 똑같이 key로 놔둔거임

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final String video = "asset/sample1.mp4";
  // interface라던지 with를 사용함 TickerProviderStateMixin -> 화면 부드럽게 전환시켜줌
  TabController? controller; // tab controller 객체 생성 -> 밖에 빼도 괜찮음
  // 인스턴스 변수 사용이유: 밑에도 쭉 사용하기위해서

  @override
  void initState() {
    super.initState(); // 최초 실행

    controller = TabController(length: 2, vsync: this);
    controller!
        .addListener(tabListener); // controller에 addlistener를 추가해서 처리하면 이벤트 동작
    // tablistener를 제거하기위해서 dispose 함수를 무조건 추가해야함
  }

  tabListener() {
    setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: renderChildren(), // 여기에 리턴을 받을 예정
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: Colors.tealAccent,
      currentIndex: controller!.index,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        ),
      ],
    );
  }

  List<Widget> renderChildren() {
    return [
      Scaffold(
        body: ListView(
          children: [
            VideoCard(video: video!),
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
      ),
      AddSchedule(),
    ];
  }

}
