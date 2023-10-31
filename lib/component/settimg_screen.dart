import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  final ValueChanged<int>? onChanged;

  const SettingScreen({Key? key, this.onChanged}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double _sliderValue = 0.0;
  int alpha = 0;

  void _saveSettings() {
    // 설정 저장 하는 버튼
    print('설정이 저장되었습니다. 알파 값: $alpha');
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알람 설정 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('미리 알람 시간: ${_sliderValue.round()} 분'), // 정수로 변환하여 표시
            Slider(
              value: _sliderValue,
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                  widget.onChanged?.call(newValue.round());
                  alpha = newValue.round();// 정수로 반올림하여 전달
                });
              },
              min: 0,
              max: 60,
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0), // 상단 여백 추가
              child: Text(
                '목적지까지 걸리는 시간 + $alpha 분',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            ElevatedButton(
              onPressed: _saveSettings, // 버튼을 눌렀을 때 _saveSettings 함수 실행
              child: Text('설정 저장'),
            ),
          ],
        ),
      ),
    );
  }
}
