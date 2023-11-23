import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:miniproject/component/database.dart';

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
  bool notificationsEnabled = true;


  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings('ic_stat_action_alarm'); // 여기에 앱 아이콘의 이름을 넣어주세요
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _saveSettings() async {
    if(!notificationsEnabled){
      return;
    }
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
                '출발 알림',
                '지금 출발 하셔야 합니다.',
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
                '출발 알림',
                '지금 출발 하셔야 합니다.',
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
                '출발 알림',
                '지금 출발 하셔야 합니다.',
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
                '출발 알림',
                '지금 출발 하셔야 합니다.',
                scheduledTime,
                platformChannelSpecifics,
                androidAllowWhileIdle: true,
              );
            }

            print('예약된 알림 시간: $scheduledTime');
          }else{
            print('시간오류');
          }
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text('알림 설정 완료'),
                content: Text('알림이 설정되었습니다. $cal_alarm 분 후 알림이 울립니다.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('확인'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),

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
              activeColor: Colors.indigo[500],
              inactiveColor: Colors.grey,
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
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo[500],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  notificationsEnabled = !notificationsEnabled;
                  if (!notificationsEnabled) {
                    // 알림을 비활성화할 때 예약된 모든 알림을 취소합니다
                    flutterLocalNotificationsPlugin.cancelAll();
                  }
                });
              },
              child: Text(notificationsEnabled ? '알림 비활성화' : '알림 활성화'),
              style: ElevatedButton.styleFrom(primary: Colors.indigo[500],),
            ),

          ],
        ),
      ),
    );
  }
}