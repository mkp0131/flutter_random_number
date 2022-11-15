# random_numbers

## [flutter] map , index 사용법

- `.asMap().entries` 를 사용

```dart
void main() {
  final numbers = ['a', 'b', 'c'];

  numbers
      .asMap()
      .entries
      .map((x) {
    print(x.key);
    print(x.value);
  }).toList();
}
```

## [flutter] 생상 변수로 저장

- `lib/constant/color.dart` 를 생성

```dart
import 'package:flutter/material.dart';

const Color PRIMARY_COLOR = Color(0xFF2D2D33);
const Color RED_COLOR = Color(0xFFEA4955);
const Color BLUE_COLOR = Color(0xFF549FBF);
```

- 해당 파일을 import 해서 사용

## [flutter] 페이지 이동 Navigator.of

- 페이지 이동
- async 로 페이지에서 넘겨주는 값을 전달 받는다.
- 모바일일 경우 뒤로가기를 버튼이 아닌 다른 것으로 할 수 있기에, result 가 null 이 들어올수 있음에 주의한다.

```dart
// 모바일일 경우 뒤로가기를 버튼이 아닌 다른 것으로 할 수 있기에, result 가 null 이 들어올수 있음에 주의한다.
onSetMaxNum() async {
  final result = await Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) {
    return SettingScreen();
  }));

  print(result);

  setState(() {
    // result 가 null 일경우 가드!
    if (result != null) {
      maxNum = result;
    }
  });
}
```

- 뒤로가기
- pop() 의 파라미터로 리턴할 값을 넘겨준다.

```dart
ElevatedButton(
    onPressed: () {
        // pop 의 파라미터로 리턴 값을 넣어준다.
        Navigator.of(context).pop(maxVal.toInt());
    },
```

## [flutter] StatefulWidget 파라미터 전달 / constructor 방식

- Widget 클래스의 contructor 에서 값을 받아 필드값으로 저장

```dart
class SettingScreen extends StatefulWidget {
  final int maxNum;

  const SettingScreen({
    required this.maxNum,
    Key? key,
  }) : super(key: key);
```

- widget 에 접근은 State 가 widget에 연결된 다음 가능하다.
- 즉, 바로 widget 에 있는 값이 필드값으로 들어갈 수 없다.
- initState 를 사용하여 widget 과 State 가 연결된 다음 사용한다.

```dart
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
```