void switcher(dynamic anything){
  switch(anything){
    // 정확히 'aaa' 문자열만 매치한다
    case 'aaa':
      print('match: aaa');
      break;
    // 정확히 [1, 2] 리스트만 매치한다
    case [1, 2]:
      print('match: [1, 2]');
      break;
    // 3개의 값이 들어 있는 리스트를 모두 매치한다
    case [_, _, _]:
      print('match [_, _, _]');
      break;
    // 첫 번째와 두 번째 값에 int가 입력된 리스트를 매치한다
    case [int a, int b]:
      print('match: [int $a, int $b]');
      break;
    // 첫 번째 값에 String, 두 번째 값에 int가 입력된 Record 타입을 매치한다
    case (String a, int b):
      print('match: (String: $a, int: $b)');
      break;
    // 아무것도 매치되지 않을 경우 실행한다
    default:
      print('no match');
  }
}

void main() {
  // match: aaa 출력
  switcher('aaa');
  // match: [1, 2] 출력
  switcher([1, 2]);
  // match: [_, _, _] 출력
  switcher([3, 4, 5]);
  // match: [int 6, int 7] 출력
  switcher([6, 7]);
  // match: (String: 민지, int: 19) 출력
  switcher(('민지', 19));
  // no match 출력
  switcher(8);
}