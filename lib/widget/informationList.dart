import 'package:flutter/cupertino.dart';

List<Padding> reserveInformationList = [
  const Padding(
    padding: EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "1. 예약은 정각으로만 예약 가능",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
            "예약은 정각을 기준으로 예약 됩니다. \n ( ex) 12:30, 12:14, 13:05 와 같은 정각 예약이 아닐 경우 예약은 불가능 합니다. ) "),
        SizedBox(
          height: 8,
        ),
        Text("예약 시간 선택 시 분 단위가 나오더라도 시각 부분만 확인하여 예약 부탁드립니다."),
      ],
    ),
  ),
  const Padding(
    padding: EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "2. 예약 가능 시간 확인",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 2,
        ),
        Text('오른쪽 "예약 가능 시간" 버튼에서 예약 가능한 시간을 확인 하신 후 예약 부탁드립니다. \n\n'
            '확인 후 아래 "예약 시간(선택)" 에서 날짜와 시간을 각각 선택합니다.'),
      ],
    ),
  ),
  const Padding(
    padding: EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "2. 예약 가능 시간 확인",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 2,
        ),
        Text('오른쪽 "예약 가능 시간" 버튼에서 예약 가능한 시간을 확인 하신 후 예약 부탁드립니다. \n\n'
            '확인 후 아래 "예약 시간(선택)" 에서 날짜와 시간을 각각 선택합니다.'),
      ],
    ),
  ),
  const Padding(
    padding: EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "2. 예약 가능 시간 확인",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 2,
        ),
        Text('오른쪽 "예약 가능 시간" 버튼에서 예약 가능한 시간을 확인 하신 후 예약 부탁드립니다. \n\n'
            '확인 후 아래 "예약 시간(선택)" 에서 날짜와 시간을 각각 선택합니다.'),
      ],
    ),
  ),
  const Padding(
    padding: EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "2. 예약 가능 시간 확인",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 2,
        ),
        Text('오른쪽 "예약 가능 시간" 버튼에서 예약 가능한 시간을 확인 하신 후 예약 부탁드립니다. \n\n'
            '확인 후 아래 "예약 시간(선택)" 에서 날짜와 시간을 각각 선택합니다.'),
      ],
    ),
  ),
  const Padding(
    padding: EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "3. 예약 시간(선택)에서 시간 결정",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
            '예약 시간(선택)에서 각각 날짜와 시간을 선택하면 "예약 종료 시간"에 예약 시 종료 시간이 나타납니다, \n\n'
                '예약 종료 시간은 예약 시간 기준 1시간 입니다. \n\n '
                '이후 예약 연장할 경우 재예약 하셔야 합니다.'),
        SizedBox(
          height: 8,
        ),
      ],
    ),
  )
];
