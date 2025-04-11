class Idol {
  final String name;
  final int membersCount;

  Idol(this.name, this.membersCount);

  void sayName() {
    print('저는 ${this.name}입니다.');
  }

  void sayMembersCount() {
    print('${this.name} 멤버는 ${this.membersCount}명입니다.');
  }
}

class GirlGroup extends Idol {
  // 상속에서처럼 super 키워드를 사용해도 되고 다음처럼 생성자의 매개변수로 직접 super 키워드를 사용해도 된다
  GirlGroup(
      super.name,
      super.membersCount
  );
  
  // override 키워드를 사용해 오버라이드 한다
  @override
  void seyName() {
    print('저는 여자 아이돌 ${this.name}입니다.');
  }
}

void main() {
  GirlGroup redVelvet = GirlGroup('블랙핑크', 4);
  
  redVelvet.sayName(); // 자식 클래스의 오버라이드된 메서드 사용
  redVelvet.sayMembersCount(); // 부코 클래스의 메서드 사용
}

