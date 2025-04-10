class Idol {
  // _로 변수명을 시작하면
  // 프라이빗 변수를 선언할 수 있다.
  String _name;

  Idol(this._name);
}

void main() {
  Idol blackPink = Idol('블랙핑크');

  // 같은 파일에서는 _name 변수에 접근할 수 있지만
  // 다른 파일에서는 _name 변수에 접근할 수 없다.
  print(blackPink._name);
}