import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:miniproject/component/database.dart';

void main() => runApp(MaterialApp(home: SettingScreen()));

class SettingScreen extends StatefulWidget {
  final ValueChanged<int>? onChanged;

  const SettingScreen({Key? key, this.onChanged}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  double _sliderValue = 0.0;
  int alpha = 0;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings('ic_stat_action_alarm'); // 여기에 앱 아이콘의 이름을 넣어주세요
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _saveSettings() async {
    for (int i = 1; i < 5; i++) {
      Map<String, dynamic>? row = await DatabaseHelper().getRowById(i);
      var cal_alarm;
      DateTime now = DateTime.now();

      if (row != null) {
        String? date = row['date'];

        if (date != null) {
          DateTime datetime = DateTime.parse(date);
          if (now.isAfter(datetime)) {
            Duration difference = now.difference(datetime);
            int differenceInMinutes = difference.inMinutes;
            int caltime = int.parse(row['caltime']);
            cal_alarm = differenceInMinutes + caltime + alpha;

            DateTime scheduledTime = now.add(Duration(minutes: cal_alarm));

            if(i == 1) {
              var androidPlatformChannelSpecifics1 = AndroidNotificationDetails(
                '1your_channel_id_$i', 'your_channel_name_$i',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
              );
              var platformChannelSpecifics = NotificationDetails(
                  android: androidPlatformChannelSpecifics1);
              await flutterLocalNotificationsPlugin.schedule(
                0,
                '알림 제목',
                '알림 내용',
                scheduledTime,
                platformChannelSpecifics,
                androidAllowWhileIdle: true,
              );
            }
            if(i == 2) {
              var androidPlatformChannelSpecifics2 = AndroidNotificationDetails(
                '2your_channel_id_$i', 'your_channel_name_$i',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
              );
              var platformChannelSpecifics = NotificationDetails(
                  android: androidPlatformChannelSpecifics2);
              await flutterLocalNotificationsPlugin.schedule(
                0,
                '알림 제목',
                '알림 내용',
                scheduledTime,
                platformChannelSpecifics,
                androidAllowWhileIdle: true,
              );
            }
            if(i == 3) {
              var androidPlatformChannelSpecifics3 = AndroidNotificationDetails(
                '3your_channel_id_$i', 'your_channel_name_$i',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
              );
              var platformChannelSpecifics = NotificationDetails(
                  android: androidPlatformChannelSpecifics3);
              await flutterLocalNotificationsPlugin.schedule(
                0,
                '알림 제목',
                '알림 내용',
                scheduledTime,
                platformChannelSpecifics,
                androidAllowWhileIdle: true,
              );
            }
            if(i == 4) {
              var androidPlatformChannelSpecifics4 = AndroidNotificationDetails(
                '4your_channel_id_$i', 'your_channel_name_$i',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
              );
              var platformChannelSpecifics = NotificationDetails(
                  android: androidPlatformChannelSpecifics4);
              await flutterLocalNotificationsPlugin.schedule(
                0,
                '알림 제목',
                '알림 내용',
                scheduledTime,
                platformChannelSpecifics,
                androidAllowWhileIdle: true,
              );
            }

            print('예약된 알림 시간: $scheduledTime');
          }else{
            print('시간오류');
          }
        }
      }
    }
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
            Text('미리 알람 시간: ${_sliderValue.round()} 분'),
            Slider(
              value: _sliderValue,
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                  widget.onChanged?.call(newValue.round());
                  alpha = newValue.round();
                });
              },
              min: 0,
              max: 60,
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                '목적지까지 걸리는 시간 + $alpha 분',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text('설정 저장'),
            ),
          ],
        ),
      ),
    );
  }
}
