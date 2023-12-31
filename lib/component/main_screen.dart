import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/component/schedule_card.dart';
import 'package:miniproject/component/setting_screen.dart';
import 'package:miniproject/component/video_card.dart';
import '../const/colors.dart';
import 'add_schedule.dart';
import '../component/database.dart';
import 'package:miniproject/component/detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final String video = "asset/actionvideo.mp4";
  String appBarTitle = '일정'; // 메인스크린과 세팅스크린의 앱바 문구 유동적으로 바꾸기

  TabController? controller;
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> schedules = [];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller!.addListener(tabListener);
    _loadSchedules();
  }

  void _loadSchedules() async {
    List<Map<String, dynamic>> loadedSchedules = await dbHelper.queryAll();
    setState(() {
      schedules = loadedSchedules;
    });
  }

  tabListener() { // 슬라이드로 메인과 세팅스크린 넘어갈 때도 앱바 문구 바꾸기
    setState(() {
      if (controller!.index == 0) {
        appBarTitle = '일정';
      } else if (controller!.index == 1) {
        appBarTitle = '알람 설정 화면';}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 추가 부분
        title: Text(appBarTitle), //Text('일정')
        backgroundColor: Colors.indigo[500],
      ),
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(

      backgroundColor: Colors.indigo,
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
        backgroundColor: Color(0xFFF5F5DC),
        body: _buildScheduleList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo[500],
          onPressed: () {
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
      SettingScreen(),
    ];
  }

  Widget _buildScheduleList() {

    if (schedules.isEmpty) {
      return SafeArea(
        child: Center(
          child: Text('스케쥴 데이터가 없습니다.'),
        ),
      );
    }

    return ListView.builder(
        itemCount: schedules.length, // 스케줄 개수
        itemBuilder: (BuildContext context, int index) {
          String dateString = schedules[index]['date']; // 날짜
          DateTime date = DateTime.parse(dateString);
          DateTime firstDay = date; // 디데이 날짜 계산

          String formattedDate = '${date.year}-${date.month}-${date.day}';
          String reserveTime = schedules[index]['time']; // 시간
          String distance = schedules[index]['distance']; // 거리
          String transportation = schedules[index]['transportation']; // 이동수단
          String locationtext = schedules[index]['locationtext']; // 장소
          String type = schedules[index]['type']; // 종류(학교, 회사, 개인 약속)
          String caltime = schedules[index]['caltime']; // 걸리는 시간

          return GestureDetector(
            onTap: () => _onScheduleCardClicked(
              context,
              schedules[index]['description'], // 내용
              formattedDate, // 날짜 (년-월-일),
              reserveTime, // detail_screen에서 보이게 전달하기
              distance,    // 떨어진 거리
              transportation, // 이동수단
              locationtext, // 장소
              type, // 타입
              firstDay,
            ),
            child: ScheduleCard(
              content: schedules[index]['description'], // 내용
              date: formattedDate,
              firstDay: firstDay, // 디데이 날짜 계산에 필요
              type: type,
              // reserveTime: reserveTime, // 시간 안 보이게
            ),
          );
        }
      //},
    );
  }



  void _onScheduleCardClicked(BuildContext context, String content, String date, String reserveTime,
      String distance, String transportation, String locationtext, String type, DateTime firstDay) {
    // 클릭하면 DetailScreen으로 넘어가기(내용도 보내기)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(content: content, date: date, reserveTime: reserveTime,
        distance: distance, transportation: transportation, locationtext: locationtext, type: type, firstDay: firstDay,)),
    );
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);
    super.dispose();
  }
}