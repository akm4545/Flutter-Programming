void main() {
  print('hello world');
  
  // 주석을 작성하는 첫 번째 방법은
  // 한 줄 주석
  
  /*
  * 여러 줄 주석 방법이다
  * 시작 기호는 /*이고 끝나는 기호는 */이다
  * 필수는 아니지만 관행상 중간 줄의 시작으로 *를 사용한다 
  */
  
  /// 슬래시 세 개를 사용하면
  /// 문서 주석을 작성할 수 있다
  /// DartDoc이나 안드로이드 스튜디오 같은 
  /// IDE에서 문서(Documentation)로 인식한다

  var name = '코드팩토리';
  print(name);

  // 변수값 변경 가능
  name = '골든래빗';
  print(name);

  // 변수명 중복은 붕가능
  // 그래서 다음 코드에서 주석을 제거하면 코드에서 에러 발생
  // var name = '김고은';

  dynamic name2 = '코드팩토리';
  name2 = 1;

  final String name3 = '블랙핑크';
  // name3 = 'BTS'; 에러 발생 final로 선언한 변수는 선언 후 값을 변경할 수 없음

  const String name4 = 'BTS';
  // name4 = '블랙핑크'; 에러 발생 const로 선언한 변수는 선언 후 값을 변경할 수 없음

  final DateTime now = DateTime.now();

  print(now);

  // 에러
  // const DateTime now2 = DateTime.now();
  //
  // print(now);

  // String - 문자열
  String name5 = '코드팩토리';

  // int - 정수
  int isInt = 10;

  // double - 실수
  double isDouble = 2.5;

  // bool - 불리언 (true/false)
  bool isTrue = true;

  print(name5);
  print(isInt);
  print(isDouble);
  print(isTrue);

  // 리스트에 넣을 타입을 <> 사이에 명시할 수 있다
  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  print(blackPinkList);
  print(blackPinkList[0]); // 첫 원소 지점
  print(blackPinkList[3]); // 마지막 원소 지점

  print(blackPinkList.length); // 길이 반환

  blackPinkList[3] = '코드팩토리'; // 3번 인덱스값 변경
  print(blackPinkList);

  blackPinkList.add('코드팩토리'); // 리스트의 끝에 추가
  print(blackPinkList);

  final newList = blackPinkList.where(
      (name) => name == '리사' || name == '지수', // 리사 또는 지수만 유지
  );

  print(newList);
  print(newList.toList()); // Iterable을 List로 다시 변환할 때 .toList() 사용

  final newBlackPink = blackPinkList.map(
      (name) => '블랙핑크 $name', // 리스트의 모든 값 앞에 '블랙핑크' 추가
  );

  print(newBlackPink);
  print(newBlackPink.toList());

  final allMembers = blackPinkList.reduce((value, element) => value + ', ' + element); // 리스트를 순회하며 값들을 더한다

  print(allMembers);
}

