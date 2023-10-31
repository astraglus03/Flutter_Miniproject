import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 실제 앱을 그려주는 Class 만들기
  DateTime firstDay = DateTime.now(); // 상태 관리할 값 : 처음 만난 날

  @override
  Widget build(BuildContext context) {
    // 그림 그림
    return Scaffold(
        backgroundColor: Colors.pink[100], // 배경색 분홍색으로 변경
        body: SafeArea(
          // 시스템 UI 피해서 UI 그리기
          top: true,
          bottom: false, // 이미지를 자연스럽게 구현하기 위해 아래에는 미적용
          child: Column(
            // 위, 아래 끝에 위젯 각각을 배치
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // 반대 축 최대 크기로 늘리기
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ // 화면에 위는 _DDay, 아래는 _게르스이미지 위젯 띄우기
              _DDay(
                // 하트 눌렀을 때 실행할 함수 전달하기 (아래 _DDay에서 먼저 작성하고, void로 정의하고,
                // _DDay 위젯 생성자에 추가된 매개변수 onHeartPressed에 여기(_홈스크린스태이트)서 정의한 온프레스드 함수 입력해주기
                onHeartPressed: onHeartPressed, // 앞에는 변수, 뒤에는 메소드(콜백함수). 완전 다름 // 콜백함수를 매개변수로 노출해서 상태관리하기
                firstDay: firstDay, // D-Day 계산하려면 처음 만난 날 알기 (firstDay 연동), 이 값 입력하고, 이 변수를 기반으로 날짜와 D-Day가 렌더링되게 하겠다
              ),
              _GersImage(),
            ],
          ),
        )
    );
  }
  // 하트 아이콘을 클릭했을 때 실행할 함수를 정의
  void onHeartPressed() {
    showCupertinoDialog( // 쿠퍼티노 다이얼로그를 실행하는 함수
      context: context,  // BuildContext를 반드시 입력해야 함 // 보여줄 다이얼로그 빌드
      builder: (BuildContext context) { // builder 함수에 다이얼로그로 띄우고 싶은 위젯을 반환해주면 됨
        // Align 위젯은 자식 위젯을 어떻게 위치할지 정할 수 있음
        return Align(
            alignment: Alignment.bottomCenter, // alignment 매개변수에 Alignment값을 입력 가능(아래 중간에 위치) 246p
            child: Container(
              color: Colors.white, // 다이얼로그 뒤에 반투명. 흰색으로 바꾸기
              height: 300, // 다이얼로그 크기 더 작게 설정
              // 날짜 선택하는 다이얼로그
              child: CupertinoDatePicker(
                // 시간 제외하고 날짜만 선택하기
                mode: CupertinoDatePickerMode.date, //.time, .dateAndTime
                // 선택한 날짜가 변경되면 실행되는 함수(쿠퍼티노데이트피커 구현했고, setState()로 상태 관리도 구현했으면, 이 둘을 연결)->선택 날짜 바꾸면 처음 만난 날 바뀌게
                onDateTimeChanged: (DateTime date) {
                  // 상태 변경 시 setState() 함수 실행 (매개변수에 함수를 입력하고, 함수에 변경하고 싶은 변수값을 지정)
                  setState(() { // build 함수 재실행
                    firstDay = date;  // 콜백함수 실행될 때마다, 매개변수로 제공되는 date 값을 firstDay 변수에 저장해주면 됨
                  });
                },
              ),
            ));
      },
      barrierDismissible: true, // 배리어: 플러터에서 다이얼로그 위젯 외에 흐림 처리가 된 부분 (다이얼로그 위젯 높이 300, 화면 전체 높이 1000) -> 나머지 700 부분
      // 배리어를 눌렀을 때 다이얼로그가 닫히고, false를 입력하면 닫히지 않음 // 외부 탭하면 다이얼로그 닫기
    );
  }
}

// 위젯1. 이름 첫 글자가 _이면 다른 파일에서 접근x. 그래서 파일을 불러오기 했을 때 불필요한 값들이 한 번에 불러와지는 걸 방지할 수 있음
class _DDay extends StatelessWidget {
  // 하트 눌렀을 때 실행할 함수
  final GestureTapCallback onHeartPressed;

  final DateTime firstDay; // 만나기 시작한 날

  _DDay({
    required this.onHeartPressed, // 상위에서 함수 입력받기 (on하트프레스드의 값을 생성자 매개변수를 통해 외부에서 정의받음)
    required this.firstDay, // 날짜 변수로 입력받기 (여기는 생성자. 외부(홈스태이트)에서 입력 받도록 정의
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme; // text 테마 (13가지 text 스타일을 따로 저장해서, 프로젝트에서 불러와서 사용할 수 있음)
    final now = DateTime.now(); // 현재 날짜 시간

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          // 최상단 U&I 글자
          'I&GE', style: textTheme.headline1,
        ),
        const SizedBox(height: 16.0),
        Text(
          // 두 번째 글자
          '우리 처음 만난 날',
          style: textTheme.bodyText1,
        ),
        Text(
          // 처음 만난 년도일
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textTheme.bodyText2,
        ),
        const SizedBox(height: 16.0),
        IconButton(
          // 하트 아이콘 버튼
          iconSize: 60.0,
          onPressed: onHeartPressed, // 아이콘 눌렀을 때 실행할 함수
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          // 만난 후 DDay 계산하기
          'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}', // 첫 날이 오늘부터 1일인 경우, 1 더함
          style: textTheme.headline2,
        ),
      ],
    );
  }
}

// 위젯2
class _GersImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // 핸드폰 화면의 비율과 해상도가 다름. 작으면 오버플로(넘어감) 발생. 이걸 방지하기 위해, 이미지가 남는 공간만큼만 차지하도록 위젯 사용
      // Expanded 추가
      child: Center(
        // 이미지 중앙정렬
        child: Image.asset(
          'asset/img/cat5.png',

          // 화면의 반만큼 높이 구현
          height: MediaQuery.of(context).size.height / 2, // 화면의 너비와 높이를 가져와서 반만큼 이미지가 차지하도록 설정
        ),
      ),
    );
  }
}