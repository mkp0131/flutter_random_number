import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_numbers/component/number_row.dart';
import 'package:random_numbers/constant/color.dart';
import 'package:random_numbers/screen/setting_screen.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> numberList = [123, 456, 789];
  int maxNum = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(onPressed: onSetMaxNum),
              _Body(numberList: numberList),
              _Footer(onPressed: onRanNumGenerator),
            ],
          ),
        ),
      ),
    );
  }

  onRanNumGenerator() {
    final random = Random();
    Set<int> newRanNums = {};
    while (newRanNums.length < 3) {
      final number = random.nextInt(maxNum);
      newRanNums.add(number);
    }
    setState(() {
      numberList = newRanNums.toList();
    });
  }

  // 모바일일 경우 뒤로가기를 버튼이 아닌 다른 것으로 할 수 있기에, result 가 null 이 들어올수 있음에 주의한다.
  onSetMaxNum() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SettingScreen(maxNum: maxNum);
    }));

    setState(() {
      // result 가 null 일경우 가드!
      if (result != null) {
        maxNum = result;
      }
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: WH_COLOR,
          ),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.settings,
              color: RED_COLOR,
            ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> numberList;

  const _Body({Key? key, required this.numberList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: numberList.asMap().entries.map((numbers) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: numbers.key == 2 ? 0 : 20,
          ),
          child: NumberRow(numbers: numbers.value),
        );
      }).toList(),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('생성하기!'),
      style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
    );
  }
}
