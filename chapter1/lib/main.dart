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

  // reduce() 함수와 마찬가지로 각 요소를 순회하며 실행된다
  // element.length -> 글자의 길이 추출
  final allMembers2 = blackPinkList.fold<int>(0, (value, element) => value + element.length);

  print(allMembers2);

  Map<String, String> dictionary = {
    'Harry Potter': '해리 포터', // 키 : 값
    'Ron Weasley': '론 위즐리',
    'Hermione Granger': '헤르미온느 그레인저',
  };

  print(dictionary['Harry Potter']);
  print(dictionary['Hermione Granger']);
  
  print(dictionary.keys);
  // Iterable이 반환되기 때문에 .toList()를 실행해서 List를 반환받을 수도 있음
  print(dictionary.values);

  Set<String> blackPinkSet = {'로제', '지수', '리사', '제니', '제니'}; // 제니 중복

  print(blackPinkSet);
  print(blackPinkSet.contains('로제')); // 값이 있는지 확인하기
  print(blackPinkSet.toList()); // 리스트로 변환하기

  List<String> blackPink2 = ['로제', '지수', '지수'];
  print(Set.from(blackPink2)); // List 타입을 Set 타입으로 변환

  Status status = Status.approved;
  print(status); // Status.approved

  double number = 2;

  print(number + 2); // 4 출력
  print(number - 2); // 0 출력
  print(number * 2); // 4 출력
  print(number / 2); // 1 출력, 나눈 몫
  print(number % 3); // 2 출력, 나눈 나머지

  // 단항 연산
  number++; // 3
  number--; // 2
  number += 2; // 4
  number -= 2; // 0
  number *= 2; // 4
  number /= 2; // 1

  // 타입 뒤에 ?를 명시해서 null값을 가질 수 있다
  double? number1 = 1;

  // 타입 뒤에 ?를 명시하지 않아 에러가 난다
  // double number2 = null;

  double? number3; // 자동으로 null값 지정
  print(number3);

  number ??= 3; // ??를 사용하면 기존 값이 null일 때만 저장
  print(number3);

  number3 ??= 4; // null이 아니므로 3이 유지된다.
  print(number3);

  int number4 = 1;
  int number5 = 2;

  print(number4 > number5); // false
  print(number4 < number5); // true
  print(number4 >= number5); // false
  print(number4 <= number5); // true
  print(number4 == number5); // false
  print(number4 != number5); // true

  int number6 = 1;

  print(number6 is int); // true
  print(number6 is String); // false
  print(number6 is! int); // false !는 반대를 의미
  print(number6 is! String); // true

  bool result = 12 > 10 && 1 > 0; // 12가 10보다 크고 1이 0보다 클 때
  print(result); // true

  bool result2 = 12 > 10 && 0 > 1; // 12가 10보다 크고 0이 1보다 클 때
  print(result2); // false

  bool result3 = 12 > 10 || 1 > 0; // 12가 10보다 크거나 1이 0보다 클 때
  print(result3); // true

  bool result4 = 12 > 10 || 0 > 1; // 12가 10보다 크거나 0이 1보다 클 때
  print(result4); // true

  bool result5 = 12 < 10 || 0 > 1; // 12가 10보다 작거나 0이 1보다 클 때
  print(result5); // false

  int number7 = 2;

  if(number % 3 == 0){
    print('3의 배수입니다.');
  }else if(number % 3 == 1){
    print('나머지가 1입니다.');
  }else{
    // 조건에 맞지 않기 떄문에 다음 코드 실행
    print('맞는 조건이 없습니다.');
  }

  switch (status){
    case Status.approved:
      // approved 값이기 때문에 다음 코드가 실행된다
      print('승인 상태입니다.');
      break;
    case Status.pending:
      print('대기 상태입니다.');
      break;
    case Status.rejected:
      print('거절 상태입니다.');
      break;
    default:
      print('알 수 없는 상태입니다.');
  }

  // Enum의 모든 수를
  // 리스트로 반환한다
  print(Status.values);
}

enum Status {
  approved,
  pending,
  rejected
}



