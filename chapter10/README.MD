# **만난 지 며칠 U&I (상태 관리, CupertinoDatePicker, Dialog, DateTime)**  
# **프로젝트 구상하기**  
이번 프로젝트에서 집중할 요소는 두 가지이다. 첫 번째는 StatefulWidget을 이용한 상태 관리이다. 9장에서 전자액자 앱을 
만들며 StatefulWidget의 생명주기를 사용했지만 setState() 함수를 사용한 상태 관리는 아직 안 해봤다. 이번 프로젝트는 
setState() 함수 사용법을 알아본다. 두 번째는 쿠퍼티노 위젯이다.  
  
플러터는 두 가지 디자인 시스템을 지원한다. 구글의 머티리얼 디자인을 기반으로 하는 Material 위젯과 iOS 스타일의 디자인인 
Cupertiono 위젯이다. 이번 프로젝트를 진행하면서 다이얼로그 및 데이터픽커를 Cupertino 위젯을 사용해서 구현한다.  
  
# **사전 지식**  
# **setState() 함수**  
State를 상속하는 모든 클래스는 setState() 함수를 사용할 수 있다. setState() 함수가 실행되는 과정은 다음과 같이 
5단계이다.  
  
![img.png](image/img.png)  
  
1. StatefulWidget의 렌더링이 끝나고 클린 상태이다.  
2. 플러터에서는 그 어떤 상태 변경 툴을 사용하든 클린 상태에서 상태를 변경해줘야 한다. setState()를 실행해서 원하는
속성들을 변경한다.  
3. 속성이 변경되고 위젯의 상태가 더티로 설정된다.  
4. build() 함수가 실행된다.  
5. State가 클린 상태로 다시 되돌아온다.  
  
setState() 함수를 실행하는 방법은 매우 간단하다. setState() 함수는 매개변수 하나를 입력받는다. 이 매개변수는 콜백 
함수이고 이 콜백 함수에 변경하고 싶은 속성들을 입력해주면 해당 코드가 반영된 뒤 build() 함수가 실행된다. 콜백 함수가 
비동기로 작성되면 안 된다는 점에 주의하자.  
  
![img.png](image/img2.png)  
  
setState() 함수의 첫 번째 매개변수에 상태(변수) 값을 변경하는 로직을 작성한다. 예제에서는 number라는 값을 1만큼 
증가시키고 다시 build() 함수를 실행한다.  
  
# **showCupertinoDialog() 함수**  
showCupertinoDialog()는 다이얼로그를 실행하는 함수이다. Cupertino라고 정의된 만큼 iOS 스타일로 다이얼로그가 실행되며 
실행 시 모든 애니메이션과 작동이 iOS 스타일로 적용된다.  
  
![img.png](image/img3.png)  
  
1. Cupertino 위젯을 사용하려면 Cupertino 패키지를 꼭 불러와야 한다.  
2. showCupertinoDialog() 함수를 실행하면 Cupertino 스타일의 다이얼로그를 실행할 수 있다.  
3. 모든 showDialog() 형태의 함수들은 BuildContext를 반드시 입력해야 한다.  
4. 플러터에서 다이얼로그 위젯 외에 흐림 처리가 된 부분을 배리어라고 부른다. 예를 들어 아이럴로그 위젯의 높이가 300인데 
화면 전체의 높이가 1000이라면 나머지 700만큼의 부분이 배리어가 된다. barrierDismissible에 true를 입력하면 배리어를 
눌렀을 때 다이얼로그가 닫히고 false를 입력하면 닫히지 않는다.  
5. builder() 함수에 다이얼로그로 띄우고 싶은 위젯은 반환해주면 된다.  
  
# **사전 준비**  
이번 강의에서는 에셋과 폰트를 추가해야 한다.  
  
1. 실습에 사용할 프로젝트를 생성한다.  
- 프로젝트 이름: u_and_i  
- 네이티브 언어: 코틀린  
  
# **이미지와 폰트 추가하기**  
1. 이미지와 폰트를 프로젝트에 추가한다. asset 폴더를 만들고 그 아래 font와 img 폴더를 만든다. 내려받은 예제에서 
폰트 파일들은 font 폴더에, 그림 파일들은 img 폴더에 저장한다.  
  
# **pubspec.yaml 설정하기**  
이미지와 마찬가지로 폰트도 pubspec.yaml 파일에 추가한다. 에셋 파일은 flutter 키의 assets 키에, 폰트 파일은 flutter 
키의 fonts 키에 입력하면 된다. 이미지와 폰트를 pubspec.yaml에 적용한다.  
  
pubspec.yaml 참고  
  
Weight는 폰트 두께를 의미한다. 폰트의 두께별로 파일이 따로 제공되기 때문에 같은 폰트라도 다른 두께를 표현하는 파일은 
weight 값을 따로 표현해줘야 한다. 두께값은 100부터 900까지 100 단위로 사용할 수 있으며 숫자가 높을수록 두꺼운 값을 
의미한다. 추후 플러터에서 사용할 때 fontWeight 클래스에 표현되는 두께값과 같다(예: weight: 500 = FontWeight.w500).  
  
2. pub get을 실행해서 변경 사항을 반영한다.  
  
# **프로젝트 초기화하기**  
1. lib 폴더에 screen 폴더를 생성하고 앱의 기본 홈 화면으로 사용할 HomeScreen 위젯을 생성할 home_screen.dart를 생성한다. 
다음과 같이 HomeScreen이라는 StatelessWidget을 생성한다.  
  
lib -> screen -> home_screen.dart  
  
2. lib/main.dart 파일에서도 마찬가지로 HomeScreen을 홈 위젯으로 등록한다.  
  
lib -> main.dart  
  
