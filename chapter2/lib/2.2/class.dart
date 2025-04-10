// class 키워드를 입력 후 클래스명을 지정해 클래스를 선언
class Idol {
  // 클래스에 종속되는 변수를 지정
  String name = '블랙핑크';

  // 클래스에 종속되는 함수를 지정
  void sayName() {
    // 클래스 내부의 속성을 지칭하고 싶을 때는 this 키워드를 사용
    print('저는 ${this.name}입니다.');
    // 스코프 안에 같은 속성 이름이 하나만 존재한다면 this 생략 가능
    print('저는 $name입니다.');
  }
}

void main() {
  // 인스턴스 생성
  Idol blackPink = Idol();

  blackPink.sayName();
}