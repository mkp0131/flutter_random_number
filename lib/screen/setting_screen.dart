import 'package:flutter/material.dart';
import 'package:random_numbers/component/number_row.dart';
import 'package:random_numbers/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNum;

  const SettingScreen({
    required this.maxNum,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxVal = 1000.0;

  // widget 에 접근은 State 가 widget에 연결된 다음 가능하다.
  // 즉, 바로 widget 에 있는 값이 필드값으로 들어갈 수 없다.
  // initState 를 사용하여 widget 과 State 가 연결된 다음 사용한다.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maxVal = widget.maxNum.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: NumberRow(numbers: maxVal.toInt(),),
              ),
              Slider(
                value: maxVal,
                min: 100.0,
                max: 10000.0,
                onChanged: (double value) {
                  setState(() {
                    maxVal = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // pop 의 파라미터로 리턴 값을 넣어준다.
                  Navigator.of(context).pop(maxVal.toInt());
                },
                child: Text('저장하기!'),
                style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
              )
            ],
          ),
        ),
      ),
    );
  }
}
