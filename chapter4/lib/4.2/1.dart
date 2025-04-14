void main() {
  // 아래 코드와 같지만 구조 분해를 사용하면 한 줄에 해결할 수 있다
  // final newJeans = ['민지', '해린'];
  // final minji = newJeans[0];
  // final haering = newJeans[1];
  final [minji, haerin] = ['민지', '해린'];

  // 민지 출력
  print(minji);
  // 해린 출력
  print(haerin);
}