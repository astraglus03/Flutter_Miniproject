import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:miniproject/component/database.dart';
import 'dart:math' as math;
import 'dart:io';
import '../const/colors.dart';


enum Transportation { car, walking }

class AddSchedule extends StatefulWidget {
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  late DateTime _selectedDate; //선택 날짜
  late TimeOfDay _selectedTime; //시간 선택
  late LatLng selectLocation = LatLng(37.5233273, 126.921252); //현재 위치 초기화(위도,경도) 지도 위치 변수
  late LatLng _currentLocation = LatLng(0, 0); //현재 위치 초기화

  Transportation _selectedTransportation = Transportation.car; //이동수단 변수
  TextEditingController timeController = TextEditingController(); //시간 변수
  TextEditingController locationController = TextEditingController(); //위치텍스트 변환 변수
  TextEditingController currentLocationController = TextEditingController(); //현재 위치텍스트 변환 변수
  TextEditingController distanceController = TextEditingController(); //거리 변수
  TextEditingController descriptionController = TextEditingController(); //내용변수

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _getCurrentLocation();
  }
  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        currentLocationController.text = '${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      print("Error: $e");
      // 위치를 가져오는데 실패한 경우에 대한 예외 처리를 여기에 추가할 수 있습니다.
    }
  }
  void distance() async{
    try {
      calculateDistance(_currentLocation, selectLocation);
      double distance = calculateDistance(_currentLocation, selectLocation);

      setState(() {
        distanceController.text = '${distance}';
      });
    } catch(e){
      print('거리 오류');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: _selectedDate,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                _selectedTime = TimeOfDay.fromDateTime(newDateTime);
              });
            },
          ),
        );
      },
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  double _toRadians(double degree) {//거리계산 관련 함수
    return degree * (math.pi / 180.0);
  }
  double calculateDistance(LatLng start, LatLng end) { //거리계산 함수
    const double earthRadius = 6371; // 지구 반지름 (킬로미터 단위)
    double lat1 = start.latitude;
    double lon1 = start.longitude;
    double lat2 = end.latitude;
    double lon2 = end.longitude;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) * math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) * math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    double distance = earthRadius * c; // 거리 (킬로미터 단위)
    return distance;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일정 추가'),
        backgroundColor: Colors.tealAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8.0),
                    Text(
                      '날짜 선택: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Radio(
                    value: Transportation.car,
                    groupValue: _selectedTransportation,
                    onChanged: (Transportation? value) {
                      setState(() {
                        _selectedTransportation = value!;
                      });
                    },
                  ),
                  Text('자가용'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: Transportation.walking,
                    groupValue: _selectedTransportation,
                    onChanged: (Transportation? value) {
                      setState(() {
                        _selectedTransportation = value!;
                      });
                    },
                  ),
                  Text('도보'),
                ],
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  _selectTime(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 8.0),
                    Text(
                      '시간 선택: ${_selectedTime.hour}:${_selectedTime.minute}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 200.0, // Google 지도의 높이를 200 픽셀로 제한
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: selectLocation,
                    zoom: 16,
                  ),
                  onCameraMove: (CameraPosition newPosition) {//지도 이동하기
                    setState(() {
                      selectLocation = LatLng(newPosition.target.latitude, newPosition.target.longitude);
                      //locationController.text = '${newPosition.target.latitude}, ${newPosition.target.longitude}';
                    });
                  },
                  onTap: (LatLng latLng){
                    setState(() {
                      selectLocation = latLng; //사용자가 찍은 위치
                      locationController.text = '${latLng.latitude}, ${latLng.longitude}'; //찍은 위치 밑 텍스트필드에 저장
                      distance(); //거리 계산 후 불러오기 떨어진 거리 필드에
                    });
                  },
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: '약속 장소'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: currentLocationController,
                decoration: InputDecoration(labelText: '현재 위치'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: distanceController,
                decoration: InputDecoration(labelText: '떨어진 거리'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: '내용'),
                maxLines: 3,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  var dbHelper = DatabaseHelper();
                  await dbHelper.insert({
                    'date': _selectedDate.toString(),
                    'transportation': _selectedTransportation.toString(),
                    'time': '${_selectedTime.hour}:${_selectedTime.minute}',
                    'location': locationController.text,
                    'currentLocation': currentLocationController.text,
                    'distance': distanceController.text,
                    'description': descriptionController.text,
                  });
                  // 일정이 성공적으로 추가되었음을 사용자에게 알림
                  print('일정이 성공적으로 추가되었습니다.');

                  // 데이터베이스에서 모든 일정을 가져와서 출력
                  var allSchedules = await dbHelper.queryAll();
                  print('모든 일정:');
                  allSchedules.forEach((schedule) {
                    print('Date: ${schedule['date']}, Transportation: ${schedule['transportation']}, Location: ${schedule['location']}, Time: ${schedule['time']}, Distance: ${schedule['distance']}, Description: ${schedule['description']}');
                  });
                },
                child: Text('일정 추가'),
              )


            ],
          ),
        ),
      ),
    );
  }
}


