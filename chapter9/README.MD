# **전자액자 (위젯 생명주기, PageView, Timer, SystemChrome, StatefulWidget)**  
# **프로젝트 구상하기**  
이번 프로젝트에서는 세 가지 요소에 집중한다. 첫 번째로 PageView 위젯이다. PageView 위젯은 가로 또는 세로로 스와이프해 
화면에 보이는 위젯을 변경하도록 해준다. 두 번째는 Timer다. Timer는 일정 기간을 기다리거나 주기적으로 반복 작업을 
실행하는 데 사용된다. 마지막으로는 StatefulWidget이다. 지금까지 StatelessWidget만 사용해왔는데 Timer를 효율적으로 
사용하려면 StatefulWidget과 StatefulWidget의 생명주기에 대해 알아야 한다.  
  
# **사전 지식**  
# **위젯 생명주기**  
위젯 생명주기는 위젯이 화면에 그려지는 순간부터 삭제되는 순간까지의 주기를 의미한다.  
  
# **StatelessWidget**  
지금까지 작성한 위젯은 모두 StatelessWidget이었다. 직역하면 상태가 없는 위젯이라는 뜻인데 이 위젯의 생명주기는 굉장히 
간단하다. 먼저 StatelessWidget이 빌드되면 생성자가 실행된다. 이어서 필수로 오버라이드해야 하는 build() 함수가 실행된다. 
마지막으로 build() 함수에 반환한 위젯이 화면에 렌더링된다.  
  
![img.png](image/img.png)  
  
플러터에서 모든 위젯은 Widget 클래스를 상속하고 Widget 클래스는 불변 특성을 갖고 있다. 불변이란 클래스를 한 번 생성하고 나면 
속성을 변경할 수 없다는 뜻이다.  
  
하지만 분명히 위젯의 속성을 변경해야 할 때가 있다. 예를 들어 생성자에 새로운 매개변수가 입력되는 경우이다. build() 함수에서 
매개변수 값을 사용하고 있다면 변경된 매개변수를 기반으로 build() 함수를 재실행해줘야 한다. 하지만 스테이트리스 위젯은 
불변이기 떄문에 한 번 생성된 인스턴스의 build() 함수는 재샐행되지 않는다. 대신 인스턴스를 아예 새로 생성한 후 기존 인스턴스를 
대체해서 변경 사항을 화면에 반영한다.  
  
# **StatefulWidget**  
스테이트풀위젯은 스테이트리스위젯과 다른 목적으로 탄생했다. 외부에서 위젯 생성자의 매개변수를 변경해주면 위젯이 새롭게 
생성되고 build()가 실행되기까지 과정은 StatelessWidget과 같다. 하지만 위젯 내부에서 자체적으로 build() 함수를 재실행해야 
하는 상황이 있다. 이때 StatefulWidget을 사용하면 된다.  
  
StatelessWidget과 다르게 StatefulWidget은 위젯 클래스와 스테이트 클래스 2개로 구성되어 있고 생명주기가 훨씬 복잡하다.  
  
# **상태 변경이 없는 생명주기**  
상태 변경이 없는 생명주기는 위젯이 화면에 나타나며 생성되고 화면에서 사라지며 삭제되는 과정을 의미한다. 중간에 위젯의 
상태가 변경되지 않는다.  
  
![img.png](image/img2.png)  
  
1. StatefulWidget 생성자가 실행된다.  
2. createState() 함수가 실행된다. createState() 함수는 필수로 오버라이드해야 하는 함수로 StatefulWidget과 연동되는 
State를 생성한다.  
3. State가 생성되면 initState()가 실행된다. initState()는 State가 생성되는 순간에만 단 한 번 실행되고 절대로 다시 
실행되지 않는다.  
4. didChangeDependencies()가 실행된다. initState()와 다르게 BuildContext가 제공되고 State가 의존하는 값이 변경되면 
재실행된다.  
5. State의 상태가 dirty로 설정된다. dirty 상태는 build()가 재실행돼야 하는 상태이다.  
6. 따라서 build() 함수가 실행되고 UI가 반영된다.  
7. build() 실행이 완료되면 상태가 clean 상태로 변경된다. 화면에 변화가 없으면 이 상태를 유지한다.  
8. 위젯이 위젯 트리에서 사라지면 deactivate()가 실행된다. deactivate()는 State가 일시적 또는 영구적으로 삭제될 때 실행된다.  
9. dispose()가 실행된다. 위젯이 영구적으로 삭제될 때 실행된다.  
  
# **StatefulWidget 생성자의 매개변수가 변경됐을 때 생명주기**  
StatefulWidget도 StatelessWidget처럼 하나의 클래스이다. 그렇기 때문에 매개변수를 입력받을 수 있다. 위젯이 생성된 
후 삭제가 되기 전 매개변수가 변경되면 다음 생명주기가 실행된다.  
  
![img.png](image/img3.png)  
  
1. StatefulWidget 생성자가 실행된다.  
2. State의 didUpdateWidget() 함수가 실행된다.  
3. State가 dirty 상태로 변경된다.  
4. build()가 실행된다.  
5. State의 상태가 clean으로 변경된다.  
  
# **State 자체적으로 build()를 재실행할 때 생명주기**  
StatelessWidget은 생성될 때 build() 함수가 한 번 실행되고 절대로 다시 실행되지 않는다. 반면 StatefulWidget은 
StatefulWidget 클래스와 State 클래스로 구성돼 있는데 State 클래스는 setState() 함수를 실행해서 build() 함수를 자체적으로 
재실행할 수 있다.  
  
![img.png](image/img4.png)  
  
1. setState()를 실행한다.  
2. State가 dirty 상태로 변경된다.  
3. build()가 실행된다.  
4. State의 상태가 clean으로 변경된다.  
  
# **Timer**  
Timer는 특정 시간이 지난 후에 일회성 또는 지속적으로 함수를 실행한다. 이번 프로젝트에서는 Timer.periodic()을 사용해서 
주기적으로 콜백 함수를 실행한다. Timer.periodic()은 매개변수 2개를 입력받는다.  
  
![img.png](image/img5.png)  
  
1. 콜백 함수를 실행할 주기를 지정한다. Duration에 days, hours, minutes, seconds, milliseconds, microseconds 매개변수를 
이용해서 주기를 정할 수 있다.  
2. 주기가 지날 떄마다 실행할 콜백 함수다. 매개변수에 현재 실행 중인 Timer 객체가 제공된다.  
  
Timer의 생성자는 Timer(), Timer.periodic() 두 가지다. 각각에 대해서는 다음 표를 참고하자.  
  
![img.png](image/img6.png)  
  
# **사전 준비**  
실습에 사용할 프로젝트를 생성한다.  
- 프로젝트 이름: image_carousel
- 네이티브 언어: 코틀린  
  
# **이미지 추가하기**  
에셋은 프로젝트에서 사용되는 파일들을 의미한다. 동영상, 이미지, 음악 파일 등이 예제이다. 앱에서 슬라이딩할 이미지들을 
내려받고 프로젝트에 등록한다.  
  
1. Project에서 최상의 폴더에 asset 폴더를 생성하고 그 아래 img 폴더도 생성한다.  
2. 깃허브 예제에서 이미지를 다운로드 받하 img 폴더에 넣는다.  
  
# **pubspec.yaml 설정하기**  
추가된 에셋을 pubspec.yaml에 등록한다. pubspec.yaml 파일은 프로젝트의 의존성과 에셋을 등록하는 파일이다. 프로젝트에서 
사용할 에셋 파일을 등록해줄 때는 pubspec.yaml 파일의 중간쯤에 있는 flutter 키에 assets 키를 작성하고 사용할 에셋이 있는 
위치(asset/img/)를 다음과 같이 적어준다. 마지막으로 pub get을 실행해주면 등록한 에셋을 프로젝트에서 사용할 수 있다.  
  
pubspec.yaml 참고  
  
# **프로젝트 초기화하기**  
1. lib 폴더에 screen 폴더를 생성하고 앱의 기본 홈 화면으로 사용할 HomeScreen 위젯을 생성할 home_screen.dart를 생성한다. 
  
lib -> screen -> home_screen.dart  
  
2. lib/main.dart 파일에서도 마찬가지로 HomeScreen을 홈 위젯으로 등록한다.  
  
lib -> main.dart  
  
# **레이아웃 구상하기**  
이번 프로젝트의 레이아웃은 좌우로 위젯을 스와이프할 수 있는 PageView 하나로 구성되어 있다.  
  
![img.png](image/img7.png)  
  
# **구현하기**  
구현할 프로그램의 구성은 다음과 같다.  
  
![img.png](image/img8.png)  
  
# **페이지뷰 구현하기**  
PageView는 여러 개의 위젯을 단독 페이지로 생성하고 가로 또는 세로 스와이프로 페이지를 넘길 수 있게 하는 위젯이다. 
home_screen.dart에 PageView를 추가한다.  
  
lib -> screen -> home_screen.dart  
  
PageView 위젯은 material 패키지에서 기본으로 제공해준다. children 매개변수에 페이지로 생성하고 싶은 위젯들을 넣어주면 
된다. [1, 2, 3, 4, 5] 리스트를 생성하고 map() 함수를 사용해서 image_1.jpeg부터 image_5.jpeg까지 순서대로 PageView에 
추가한다.  
  
2. 핫 리로드를 수행해서 PageView에 이미지가 추가된 걸 확인한다.  
3. 이미지가 PageView에 추가됐지만 핸드폰 크기와 이미지 크기가 달라서 위아래로 흰색 여백이 생길 수도 있다. 핸드폰 화면 
비율에 따라 위아래 대신에 좌우가 남거나 운 좋게 딱 맞을 수도 있다. 여러 비율의 화면에 대응할 수 있게 이미지 핏을 조절해줘서 
항상 전체 화면을 다 차지하도록 설정한다.  
   
lib -> screen -> home_screen.dart  
  
BoxFit.cover를 설정해주면 이미지가 최대한 전체 화면을 차지하도록 늘어난다. Image 위젯에서의 매개변수 fit은 이미지를 
부모 위젯에 어떻게 채워넣을지 정의한다. 자세한 속성은 다음 표를 참고하자.  
  
![img.png](image/img9.png)  
![img.png](image/img10.png)  
![img.png](image/img11.png)  
![img.png](image/img12.png)  
  
# **상태바 색상 변경하기**  
상태바는 앱을 실행 중에 핸드폰 배터리, 시간, 와이파이 연결 상태 등을 보여주는 영역이다. 현재 상태바의 글자 및 아이콘 
색상이 검정색이라 잘 안보이니 잘 보이게 흰색으로 변경한다. 버전에 따라서 이미 흰색인 경우도 있다. 흰색으로 나오면 연습 
삼아 검정으로 바꾸면 된다.  
  
1. HomeScreen 위젯의 build() 메서드에 상태바 아이콘들의 색상을 변경하는 코드를 추가한다.  
  
lib -> screen -> home_screen.dart  
  
SystemChrome 클래스는 시스템 UI의 그래픽 설정을 변경하는 기능을 제공한다. SystemChrome.setSystemUIOverlayStyle()을 
사용하면 상태바의 색상을 변경할 수 있다. 매개변수의 값으로는 검정색으로 만들어주는 SystemUiOverlayStyle.dark와 흰색으로 
만들어주는 SystemUiOverlayStyle.light가 있다.  
  
![img.png](image/img13.png)  
  
2. 핫 리로드를 해서 상태바의 색상이 흰색으로 변경된 걸 확인하자.  
  
# **타이머 추가하기**  
50줄도 되지 않는 코드로 벌써 목표한 UI를 완성했다. 일정 기간마다 자동으로 페이지가 변경되는 기능을 추가할 차례다. Timer 
클래스를 사용해서 액자가 자동으로 롤링되는 기능을 추가한다.  
  
Timer를 추가하려면 HomeScreen을 StatelessWidget이 아닌 StatefulWidget으로 변경해야 한다. StatelessWidget을 그대로 
사용하면 Timer를 등록할 수 있는 위치가 build() 함수밖에 없다. build()에 Timer를 등록하면 안타깝게도 위젯이 새로 
생성될 때마다, 즉 build() 함수가 불릴 때마다 매번 새로운 Timer가 생성된다. 그러면 메모리 누수가 생기게 된다. 하지만 
StatefulWidget의 생명주기에서 배운 대로 initState()를 사용하면 State가 생성될 때 딱 한 번만 Timer를 생성할 수 있다. 
그러니 HomeScreen을 StatefulWidget으로 변환한 후 Timer를 등록한다.  
  
1. HomeScreen 위젯을 StatefulWidget으로 변경한다.  
  
lib -> screen -> home_screen.dart  
  
StatefulWidget은 StatefulWidget 클래스를 상속해서 정의할 수 있다. 생명주기에서 배운 것처럼 StatefulWidget은 
createState() 함수를 정의해야 하며 State를 반환해준다.  
  
_HomeScreenState 클래스는 먼저 생성한 StatefulWidget 클래스를 매개변수로 받는 State 클래스를 상속한다. 이미 배운 
것처럼 build() 함수는 State에서 정의한다.  
  
2. initState() 함수에 Timer를 등록한다.  

lib -> screen -> home_screen.dart  
  
플러터에 기본으로 제공되는 async 패키지를 불러와야 Timer를 사용할 수 있다. initState() 함수를 오버라이드하면 
StatefulWidget 생명주기에서의 initState() 함수를 사용할 수 있다. 모든 initState() 함수는 부모의 initState() 
함수를 실행해줘야 한다. 3초마다 실행되는 Timer를 등록했다.  
  
3. initState()에 작성한 코드는 핫 리로드를 했을 때 반영이 안된다. 왜냐하면 initState()는 State가 생성될 때 딱 한 
번만 실행이 되는데 이미 StatefulWidget으로 코드를 전환하는 과정에서 State를 생성해버렸기 떄문이다. 그래서 initState()에 
추가한 사항을 반영하려면 앱을 재실행해야 한다. 앱을 재실행하고 3초마다 "실행!"이라는 글자가 콘솔에 출력된다.  
  
4. 이전 프로젝트에서 웹뷰를 조작할 때 WebViewController를 사용한 것처럼 PageView는 PageController를 사용해서 PageView를 
조작할 수 있다. PageController를 State에 선언하고 PageView에 매개변수로 입력한다.  
   
lib -> screen -> home_screen.dart  
  
사용할 pageController 변수를 정의한다. PageView의 controller 매개변수에 PageController 타입의 값을 넣어주면 해당 
컨트롤러로 PageView를 조작할 수 있다.  
  
5. PageView에 컨트롤러를 등록했으니 Timer.periodic()의 콜백 함수를 변경해서 주기적으로 PageView의 페이지를 넘겨주도록 한다.  

lib -> screen -> home_screen.dart  
  
pageController.page 게터를 사용해서 PageView의 현재 페이지를 가져올 수 있다. 페이지가 변경 중인 경우 소수점으로 표현돼서 
double로 값이 반환된다. 하지만 animateToPage() 함수를 실행할 때 정숫값을 넣어줘야 하니 미리 toInt()를 사용해서 정수로 
변환한다. 만약에 페이지가 null이면 무엇도 하지 않는다.  
  
페이지의 값이 4면 첫 번째 페이지부터 다시 시작한다. 아니면 페이지에 1을 더해서 다음 페이지로 이동한다. PageController의 
animateToPage() 함수를 사용해서 PageView의 현재 페이지를 변경할 수 있다. 첫 번째 매개변수로 이동할 페이지가 정수로 
입력되며 duration 매개변수는 이동할 때 소요될 시간을 지정할 수 있다. 마지막으로 curve 매개변수는 페이지가 변경되는 
애니메이션의 작동 방식을 정할 수 있다. 플러터에서는 수십 개의 curve 기본 설정이 제공되며 플러터 공식 페이지에서 직접 
애니메이션을 확인할 수 있다.  
  
6. initState() 함수를 변경했으니 앱을 재실행해서 새로 Timer.periodic()을 등록한다. 앱을 실행하면 3초가 지날 때마다 
페이지가 자동으로 롤링되고 마지막 페이지에 다다르면 처음으로 다시 돌아간다.  
  
