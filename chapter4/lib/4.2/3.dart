void main() {
  final minjiMap = {'name': '민지', 'age': 19};

  // 위의 맵의 구조와 똑같은 구조로 구조 분해하면 된다
  final {'name': name, 'age': age} = minjiMap;

  // name: 민지
  print('name: $name');
  // age: 19
  print('age: $age');
}