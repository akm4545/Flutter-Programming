void main() {
  final minji = Idol(name: '민지', age: 19);

  // 클래스의 생성자 구조와 똑같이 구조 분해하면 된다
  final Idol(name: name, age: age) = minji;

  print(name);
  print(age);
}

class Idol {
  final String name;
  final int age;

  Idol({
    required this.name,
    required this.age
  });
}