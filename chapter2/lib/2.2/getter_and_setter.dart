class Idol {
  String _name = '블랙핑크';
  
  // get 키워드를 사용해서 게터임을 명시
  // 게터는 메서드와 다르게 매개변수를 전혀 받지 않는다
  String get name {
    return this._name;
  }
  
  // 세터는 set이라는 키워드를 사용해서 선언
  // 세터는 매개변수로 딱 하나의 변수를 받을 수 있다.
  set name(String name){
    this._name = name;
  }
}

void main() {
  Idol blackPink = Idol();
  
  blackPink.name = '에이핑크'; // 세터
  print(blackPink.name); // 게터
}