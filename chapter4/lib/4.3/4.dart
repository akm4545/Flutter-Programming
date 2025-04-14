void main() {
  (int a, int b) val = (1, -1);

  // default가 출력된다
  // 만약에 b 값을 0 이상으로 변경하면 1, _를 출력할 수 있다
  switch(val){
    // 레코드의 2번째 변수가 0보다 크면 case 문 체크
    case(1, _) when val.$2 > 0:
      print('1, _');
      break;
    default:
      print('default');
  }
}