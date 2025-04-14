void main() {
  String dayKor = '월요일';

  // switch문이 함수처럼 값을 반환한다
  String dayEnglish = switch(dayKor){
    // =>를 사용하면 switch문 조건에 맞을 때 값을 반환할 수 있다
    '월요일' => 'Monday',
    '화요일' => 'Tuesday',
    '수요일' => 'Wednesday',
    '목요일' => 'Thursday',
    '금요일' => 'Friday',
    '토요일' => 'Saturday',
    '일요일' => 'Sunday',
    // _는 default와 같은 의미로 사용된다
    _ => 'Not Found',
  };

  // Monday 출력
  print(dayEnglish);
}