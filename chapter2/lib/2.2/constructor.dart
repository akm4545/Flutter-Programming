class Idol {
  // 생성자에서 입력받는 변수들은 일반적으로 final 키워드 사용
  final String name;

  // 생성자 선언
  Idol(String name) : this.name = name;

  void sayName() {
    print('저는 ${this.name}입니다.');
  }
}

void main() {
  Idol blackPink = Idol('블랙핑크');
  blackPink.sayName();

  Idol bts = Idol('BTS');
  bts.sayName();
}