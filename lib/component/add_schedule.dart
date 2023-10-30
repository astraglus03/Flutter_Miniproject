import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  Transportation _selectedTransportation = Transportation.car; //이동수단 변수
  TextEditingController timeController = TextEditingController(); //시간 변수
  TextEditingController locationController = TextEditingController(); //위치텍스트 변환 변수
  TextEditingController descriptionController = TextEditingController(); //내용변수

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
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
                    });
                  },
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: '장소'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: '내용'),
                maxLines: 3,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // 일정 추가 버튼 눌렀을때 실행할 것
                },
                child: Text('일정 추가'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


