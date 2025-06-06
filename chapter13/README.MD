# **영상 통화(WebRTC, 내비게이션, 아고라 API)**  
# **프로젝트 구상하기**  
일반적으로 WebRTC 기술을 사용해서 핸드폰 간의 영상 통화를 구현한다. 전체 기능을 모두 구현하려면 시간이 너무 오래 걸리고 
요점에서 벗어나기 때문에 중계 서버로 아고라라는 유료 API를 사용한다(1만 분까지는 무료로 이용할 수 있다).  
  
영상 통화를 하려면 동영상과 음성을 서로 전달해야 하기 떄문에 카메라 권한과 마이크 권한이 필요하다. 이번 프로젝트에서는 
플러터에서 가장 대중적으로 사용되는 권한 관련 플러그인인 permission_handler 플러그인을 사용해서 안드로이드와 iOS에서 
권한을 관리하는 방법을 알아본다.  
  
iOS 시뮬레이터는 영상 통화 관련 기능을 전혀 지원하지 않아서 빌드가 불가능하다. iOS 실제 기기, 안드로이드 실제 기기, 
안드로이드 에뮬레이터에서 빌드와 실습을 진행하자.  
  
# **사전 지식**  
# **카메라 플러그인**  
카메라 플러그인을 사용하면 카메라 기능을 활용할 수 있다. 이번 프로젝트에서는 아고라 플러그인을 통해서 카메라 기능을 
사용하지만 플러터 공식 플러그인인 camera 플러그인을 사용해서 카메라를 실행하는 방법을 알아보자.  
  
1. pubspec.yaml 파일에 camera 플러그인을 추가한다.  
  
pubspec.yaml 참고  
  
2. 다음 코드를 main.dart 파일에 작성한다.(tmp_main.dart)  
  
lib -> tmp_main.dart  

WidgetsFlutterBinding.ensureInitialized()은 material.dart에서 제공된다. main() 함수의 첫 실행값이 runApp() 이면 
불필요하지만 지금처럼 다른 코드가 먼저 실행돼야 하면 꼭 제일 먼저 실행해줘야 한다. availableCameras()는 기기에서 
사용할 수 있는 카메라들을 가져온다. CameraController는 카메라를 제어할 수 있는 컨트롤러다.  
  
CameraController의 첫 번째 매개변수는 사용할 카메라를 입력하게 된다. 두 번째 매개변수는 해상도를 설정하게 된다. 
ResolutionPreset.max는 최대 해상도를 의미한다.  
  
다른 값은 하단 표를 확인하자.  
  
![img.png](image/img.png)  
  
initialize()는 카메라를 초기화한다. isInitialized는 카메라 초기화가 완료된 상태인지를 알 수 있다. CameraPreview 
위젯을 사용하면 카메라를 화면에 보여줄 수 있다. 첫 번째 매개변수에 CameraController를 입력해야 한다.  
  
# **WebRTC**  
영상 통화 기능을 구현하려면 영상과 음성 정보를 저장하고 전송하기, 클라이언트 간의 연결하기 등 다양한 기능을 구현해야 한다. 
그런 기능을 모조리 구현하려면 시간이 많이 든다. 웹 브라우저 기반으로 통신하는 WebRTC라는 API가 있다. 음성 통화, 영상 통화, 
P2P 파일 공유 기능을 제공하므로 WebRTC를 사용하면 간단히 영상 통화 기능을 구현할 수 있다.  
  
WebRTC를 사용하려면 두 클라이언트 말고도 중계용 서버가 필요하다. 영어로는 시그널링 서버(Signalling Server)라고 하는데 
이 서버를 직접 구현할 수도 있지만 앱 개발에 집중하고자 아고라 서비스를 이용한다.  
  
클라이언트와 서버 간의 정보 흐름 절차를 그림을 보면서 살펴보자.  
  
![img.png](image/img2.png)  
  
1. WebRTC를 사용할 클라이언트들은 서로에게 연결할 수 있는 공개 IP 등의 정보를 서버에 전송하고 상대의 연결 정보를 받아온다.  
2. 서버에서 받아온 정보를 기반으로 내 영상 및 음성을 공유하고 상대의 영상 및 음성 정보를 이용한다.  
  
# **iOS 시뮬레이터와 안드로이드 에뮬레이터에서의 카메라 사용**  
영상 통화 앱을 구현하려면 당연히 카메라 기능을 사용한다. 하지만 안타깝게도 iOS 시뮬레이터는 카메라 기능을 아예 제공하지 
않는다. 반면에 안드로이드 에뮬레이터는 카메라 앱을 실행할 수는 있지만 실제 카메라와 연동되지는 않고 샘플 영상이 실행된다. 
그래서 이번 장에서 만든 앱을 사용하려면 카메라를 사용할 수 있는 디바이스가 두 대 필요하다. 사용할 수 있는 디바이스가 한 
대 뿐이라면 안타깝지만 하나는 안드로이드 에뮬레이터로 대체해야 한다.  
  
# **내비게이션**  
내비게이션은 플러터에서 화면을 이동할 때 사용하는 클래스이다. 내비게이션은 스택이라는 데이터 구조로 설계되어 있다. 
스택에 대해 잘 이애하면 내비게이션이 제공하는 여러 함수를 조금 더 이해하기 쉽다. 스택은 LIFO(Last In First Out) 구조, 
즉 마지막으로 들어온 요소가 가장 먼저 삭제되는 구조이다.  
  
![img.png](image/img3.png)  
  
플러터에서는 내비게이션 스택의 가장 위에 위치한 위젯을 화면으로 보여준다. Navigator 클래스에서 제공하는 메서드를 사용해서 
내비게이션 스택을 사용할 수 있다.  
  
![img.png](image/img4.png)  
  
# **플러터에서 권한 관리**  
스마트폰을 사용하다 "위치 정보를 사용하도록 허가해주세요"같은 메시지를 본 적이 있을 것이다. 특정 기능들, 특히 보안에 
민감한 기능은 사용자가 권한을 허가해줘야 앱에서 정보를 가져오거나 기능을 사용할 수 있다. 안드로이드와 iOS는 권한을 
요청하는 시스템이 비슷하다. permission_handler 패키지를 이용하면 두 플랫폼 모두에서 쉽게 권한을 관리할 수 있다.  
  
안드로이드와 iOS에는 허가를 받아야 하는 권한이 있고 허가를 받지 않아도 되는 권한이 있다. 예를 들어 블로그 웹 앱 
프로젝트에서 AndroidManifest.xml 파일에 등록한 인터넷 권한은 따로 사용자에 허가를 받지 않고 사용했다. 하지만 이번에 
사용할 카메라와 마이크 권한은 사용자에게 이용 허가를 꼭 받아야지만 사용할 수 있다. 그래서 이 권한들은 네이티브 설정에 
등록을 했더라도 플러터 프레임워크에서 권한이 허가됐는지 아닌지 확인해줘야 한다.  
  
permission_handler 플러그인은 사용법이 매우 단순하다. 플러그인의 Permission 클래스에 존재하는 권한을 선택한 후 
request() 함수를 실행하면 권한 요청을 할 수 있다. 반환 값으로는 PermissionStatus에 해당하는 enum값을 받아올 수 
있으며 PermissionStatus.granted 값을 돌려받으면 권한이 있다는 걸 의미한다.  
  
![img.png](image/img5.png)  
  
![img.png](image/img6.png)  
![img.png](image/img7.png)  
  
권한을 상황에 맞게 하나씩 요청하는 경우도 있지만 필요한 여러 권한을 한 번에 연속적으로 요청할 때도 있다. 이때는 요청하고 
싶은 권한을 순서대로 List에 넣어서 한번에 request() 함수를 실행해주면 여러 권한을 단번에 요청할 수 있다. 그리고 권한 
요청에 대한 결과는 Map 형태로 반환받으며 확인하고 싶은 권한의 값을 key로 입력해주면 권한 요청의 결과를 가져올 수 있다.  
  
![img.png](image/img8.png)  
  
# **사전 준비**  
카메라와 마이크를 사용하려면 권한 설정을 해야 한다. 아고라 API에서 필수로 요구하는 사항이니 꼭 등록해줘야 한다.  
  
1. 먼저 실습에 사용할 프로젝트를 생성한다.  
- 프로젝트 이름: video_call  
- 네이티브 언어: 코틀린  
  
# **아고라에서 필요한 상수값 가져오기**  
아고라는 영상 통화와 통화 기능 API를 유료로 제공하는 서비스이다. 이번 프로젝트에서는 아고라의 영상 통화 API를 이용한다. 
아고라 같은 유료 API를 사용하려면 여러 가지 고윳값이 필요하다. 유료 API인만큼 아고라 입장에서는 누가 어떤 기능을 얼마만큼 
사용하는지 알아야 한다. 그래서 사용자별로 토큰을 발급해주며 사용자들은 이 토큰값을 사용해서 서비스를 이용한다. 아고라가 
유료 서비스이긴 하지만 회원가입을 하면 매달 1만 분을 무료로 사용할 수 있다. 영상 통화 기능을 실수로 1만 분 이상 틀어 
놓지 않으면 과금 없이 충분히 이번 프로젝트를 마무리할 수 있다.  
  
# **아고라 가입하기**  
1. 토큰을 발급받으려면 아고라에 회원가입을 해야 한다. https://www.agora.io 로 이동해서 회원가입을 진행하면 된다.

2. 로그인 및 회원가입을 완료하면 대시보드 페이지로 이동된다. 프로젝트 생성 팝업창이 뜬다. 일단 팝업창을 종료한다. 
대시보드 페이지에서 왼쪽 사이드바에 마우스를 올린 다음 Project Management 버튼을 누른다.  
  
![img.png](image/img9.png)  
  
3. Project Management 화면으로 이동되면 Create a Project 버튼을 눌러서 새로운 프로젝트를 생성한다. Create a Project 
버튼을 눌러주면 뜨는 프로젝트 생성 창에서 프로젝트 이름, 사용 목적, Secure Mode를 선택한 후 Submit 버튼을 눌러서 
프로젝트를 생성한다.  
  
![img.png](image/img10.png)  
  
2번은 프로젝트 이름이다. 구현하려는 앱에 어울리는 이름을 지어주면 된다. 3은 아고라 API 사용 목적이다. Education -> 
Tutoring을 선택한다. 크게 중요한 부분이 아니므로 적절히 선택해주면 된다. 4번은 APP ID + Token 모드를 선택해야 한다.  
  
4. 프로젝트를 생성하면 Project Management 페이지의 테이블에 새로 만든 프로젝트가 생성된다. 방금 생성한 프로젝트의 
config 버튼을 눌러서 설정 화면으로 이동한다.  
  
![img.png](image/img11.png)  
  
5. 프로젝트 설정 페이지에 들어가면 Features 카테고리가 있다. 이 테이블에서 Generate temp RTC Token 버튼을 누른다.  
  
![img.png](image/img12.png)  
  
6. 토큰 생성 페이지로 이동하면 채널 이름을 testchannel로 설정한 후 Generate 버튼을 누르면 토큰이 생성된다. 이 페이지에서 
필요한 모든 값들을 볼 수 있다.  
  
![img.png](image/img13.png)  
  
첫 번째 App ID는 프로젝트의 유니크한 아이디를 의미한다. 두 번째 채널 이름은 핸드폰끼리 통신할 때 사용할 채널의 이름이다. 
원하는 대로 지어도 된다. 마지막으로 Temp Token은 아고라 API를 사용하는 권한이 있음을 증명하는 데 사용된다. 이 토큰을 
사용해야지만 우리 프로젝트와 연동해서 아고라 서비스를 사용할 수 있다. 추가적으로 토큰 유효기간도 적혀 있는데 모든 토큰은 
생성 후 24시간만 유효하다. 프로젝트에 필요한 값들은 App ID, Channel Name, Temp Token이니 안전한 곳에 잘 복사해두자.  
  
![img.png](image/img14.png)  
  
7. 값들을 모두 복사했다면 lib/const 폴더를 생성하고 그 아래에 agora.dart 파일을 생성해서 아고라와 관련된 값들을 
정리해준다. Temp Token은 발급받은 시간으로부터 24시간만 유효하다.  
  
lib -> const -> agora.dart  
  
# **이미지와 폰트 추가하기**  
1. asset 폴더를 만들고 그 아래 img 폴더를 만든다. 예제 그림 파일을 img 폴더에 저장한다.  
  
# **pubspec.yaml 설정하기**  
1. pubspec.yaml에 의존성과 에셋 파일을 추가한다.  
  
pubspec.yaml 참고  
  
2. pub get을 실행해서 변경 사항을 반영한다.  
  
# **네이티브 설정하기**  
안드로이드에서 추가할 네이티브 권한은 네트워크 상태를 읽는 READ_PHONE_STATE와 ACCESS_NETWORK_STATE 권한이다. 인터넷을 
이용해서 영상을 스트리밍해야 하니 INTERNET 권한도 필수이다. 그리고 녹음과 녹화 기능과 관련된 RECORD_AUDIO, MODIFY_AUDIO_SETTINGS와 
CAMERA 권한을 추가한다. 블루투스를 이용한 녹음 및 녹화 기능을 사용할 수도 있으니 BLUETOOTH_CONNECT 기능까지 추가한다. 
마지막으로 모듈의 build.gradle 파일도 변경한다. iOS는 카메라 권한인 NSCameraUsageDescription과 마이크 권한인 
NSMicrophoneUsageDescription만 추가해주면 된다.  
  
android -> app -> src -> main -> AndroidManifest.xml  
ios -> Runner -> Info.plist  
  
# **프로젝트 초기화하기**  
1. lib 폴더에 screen 폴더를 생성하고 앱의 기본 홈 화면으로 사용할 HomeScreen 위젯을 생성할 home_screen.dart를 생성한다. 
다음과 같이 HomeScreen이라는 StatelessWidget을 생성한다.  
  
lib -> screen -> home_screen.dart  
  
2. lib/main.dart 파일에서도 마찬가지로 HomeScreen을 홈 위젯으로 등록해줘야 한다.  
  
lib -> main.dart  
  
# **레이아웃 구상하기**  
이번 프로젝트는 2개의 화면으로 구성된다. 첫 번째 화면은 홈 스크린으로 화상 통화 채널에 참여할 수 있는 화면이고 두 번째 
화면은 화상 통화를 하는 화면이다. 일반적으로 화상 통화 앱을 구현한다면 홈 화면에서 참여할 채널 또는 화상 통화를 진행할 
상대를 선택하는 기능이 추가되겠지만 이 프로젝트에서는 하나의 채널만 있다는 가정하에 앱을 구현한다.  
  
# **홈 스크린 위젯**  
홈 스크린 위젯은 지금까지 구현해왔던 다른 호 화면들과 크게 다를 게 없다. 가장 위에 앱의 로고가 위치하고 중앙에 이미지가 
위치한다. 그리고 마지막에 화상 통화 채널에 참여할 수 있는 버튼을 구현한다. 별다른 특이점은 없으므로 학습 목적으로 앱의 
로고를 구현할 때 로고를 감싸고 있는 Container에 그림자를 넣어서 3D 입체감을 추가한다.  
  
# **캠 스크린 위젯**  
캠 스크린에는 영상 통화를 할 수 있는 기능을 넣어줘야 한다. 영상 통화는 1:1로 진행하게 되니 내 카메라가 찍고 있는 화면과 
상대방의 카메라가 찍고 있는 화면이 동시에 보여야 한다. 이미 이전 프로젝트에서 사용해본 Stack 위젯을 이용해서 사용 중인 
카메라가 찍고 있는 영상 위에 상대방이 찍고 있는 영상을 올린다. 추가적으로 영상 통화가 끝나면 채널에서 나갈 수 있는 기능이 
필요하니 [채널 나가기] 버튼을 맨 아래에 배치한다.  
  
![img.png](image/img15.png)  
  
# **구현하기**  
이번 프로젝트는 두 화면으로 구성되어 있다. 간단한 로고와 화상 채널 입장 버튼이 있는 홈 스크린과 화상 통화를 할 수 있는 
캠 스크린이다. 순서대로 UI를 구현한 후 Agora API를 이용해서 화상 통화하는 기능을 구현한다.  
  
# **홈 스크린 위젯 구현하기**  
1. 우선 로고, 이미지, 버튼을 각각 위젯으로 구현해서 레이아웃 설정부터 한다.  
  
lib -> screen -> home_screen.dart  
  
2. _Logo 위젯을 먼저 작업한다. _Logo 위젯은 단순히 아이콘과 글자가 Container 안에 위치한 형태이다. 로고에 그림자가 지게 
한다. 그림자는 BoxDecoration 클래스의 boxShadow 매개변수에 원하는 만큼 그림자를 BoxShadow 클래스로 제공해서 구현할 수 
있다.  
  
lib -> screen -> home_screen.dart  
  
boxShadow 매개변수에는 List로 BoxShadow 클래스를 제공할 수 있다. 일반적으로는 하나의 그림자만 사용하겠지만 원한다면 여러 
BoxShadow 클래스를 입력해서 여러 그림자를 적용할 수 있다. BoxShadow 클래스에는 그림자로 적용할 색상을 color 매개변수로 
제공해주고 blurRadius에 흐림 정도, spreadRadius에 퍼짐 정도를 double 값으로 입력할 수 있다.  
  
3. 다음은 _Image 위젯을 구현할 차례다. _Image 위젯은 크게 어려운 것 없이 이미지를 중앙에 위치하는 형태로 코드를 작성한다.  
  
lib -> screen -> home_screen.dart  
  
4. 마지막으로 화상 통화 채널에 접속할 수 있는 버튼을 구현할 _EntryButton을 작업한다. 기능은 나중에 구현하고 일단 
가로로 최대한의 길이로 늘린 ElevatedButton을 만든다.  
  
lib -> screen -> home_screen.dart  
  
5. 코드를 완료하고 핫 리로드를 하면 의도한 대로 홈 스크린이 보인다. (ElevatedButton 스타일이 달라 수정했음)  
  
# **캠 스크린 위젯 구현하기**  
1. 이제는 영상 통화를 진행할 CamScreen을 구현할 차례다. 우선 lib/screen/cam_screen.dart 파일을 생성하고 CamScreen 
StatefulWidget을 만든다. 그리고 Scaffold에 AppBar를 추가해서 기본 레이아웃을 만든다.  
  
lib -> screen -> cam_screen.dart  
  
2. CamScreen 위젯을 구현했으니 이제 HomeScreen에서 CamScreen으로 이동하는 방법을 배워야 한다. 잠시 home_screen.dart 파일로 
이동해서 ElevatedButton 위젯을 클릭하면 CamScreen 위젯으로 화면이 넘어갈 수 있게 해야 한다. 이런 기능을 플러터에서는 
내비게이션이라고 부르며 Navigator 클래스를 사용해서 구현할 수 있다. 최상위에 MaterialApp 위젯을 추가해주면 Navigator 
클래스의 인스턴스가 자동으로 생성되는데 이 값을 이용해서 화면을 이동할 수 있다.  
  
lib -> screen -> home_screen.dart  
  
테마를 이용할 때 Theme.of(context)를 사용했던 것처럼 Navigator.of(context)를 실행해서 위젯 트리의 가장 가까이에 있는 
Navigator를 가져온다. 이미 설명한 것처럼 MaterialApp으로 최상위를 감싸주면 자동으로 Navigator가 생성되며 앱 어디서든 
Navigator.of(context)를 실행해서 값을 가져올 수 있다. push() 함수를 이용하면 새로운 화면으로 이동할 수 있으며 
매개변수로 MaterialPageRoute 클래스의 builder() 함수에 새로운 화면으로 사용하고 싶은 위젯을 반환하는 함수를 입력하면 
된다.  
  
3. [입장하기] 버튼을 누르면 CamScreen 화면으로 이동할 수 있다. Navigation 기능이 완성됐으니 이제 CamScreen에서 화상 
통화 기능을 구현해야 한다. 화상 통화를 하려면 카메라 권한과 마이크 권한이 필요하다. init() 이라는 함수를 만들어서 화상 
통화에 필요한 권한을 받는다.  
  
lib -> screen -> cam_screen.dart  
  
권한을 가져오는 작업은 비동기 프로그래밍이 필요하다. 그렇기 때문에 함수를 async로 지정해주고 권한을 잘 가져왔을 땐 
true 값을 반환해주고 문제가 있으면 메시지와 함께 에러를 던지는 로직을 작성한다.  
  
4. 방금 구현한 init() 함수를 사용하려면 조금 특별한 위젯이 필요하다. build() 함수는 위젯이 생성되면 그 즉시 실행된다. 
하지만 카메라와 마이크 권한이 있을 떄 그리고 없을 때 보여줄 수 있는 화면이 달라야 한다. 문제는 init() 함수가 비동기로 
실행되니 언제 권한 요청이 끝날지 알 수 없다. 그래서 FutureBuilder 위젯을 사용한다.  
  
init() 함수에서 에러를 던지면 에러 내용을 보여주고 -> 아직 로딩 중이면 CirclearProgressIndicator를 보여주고 -> 
모든 권한이 허가되면 '모든 권한이 있습니다'라는 글자를 가운데에 보여주는 로직을 작성한다.  
  
lib -> screen -> cam_screen.dart  
  
FutureBuilder는 말 그대로 Future를 반환하는 함수의 결과에 따라 위젯을 렌더링할 때 사용한다. FutureBuilder의 future 
매개변수에 Future값을 반환하는 함수를 넣어주고 builder 매개변수에 Future값에 따라 다르게 렌더링해주고 싶은 로직을 
작서앻주면 된다. builder() 함수는 BuildContext와 AsyncSnapshot을 제공해준다. AsyncSnapshot은 future 매개변수에 
입력한 함수의 결괏값 및 에러를 제공하는 역할을 한다. 추가적으로 비동기 함수의 진행 상황도 알 수 있다. AsyncSnapshot에서 
제공하는 값이 변경될 때마다 builder() 함수가 재실행된다.  
  
AsyncSnapshot의 hasError 게터는 현재 실행한 비동기 함수에서 에러가 있는지 bool 값으로 반환해준다. true면 에러, false면 
에러가 없는 상태이다. 에러가 있을 때는 snapshot.error를 실행해서 에러값을 가져올 수 있다.  
  
AsyncSnapshot의 hsaData 게터는 현재 실행한 비동기 함수에서 반환받은 데이터가 있는지 확인할 수 있다. init() 함수는 
성공적으로 실행되면 bool 값을 반환해주니 에러가 없는데 반환받은 데이터까지 없는 상황이라면 아직 비동기 함수가 실행 중이라고 
볼 수 있다. 우리 코드에서는 사용하지 않지만 snapshot.data를 실행하면 반환된 데이터값도 받아볼 수 있다.  
  
만약에 모든 과정이 통과됐다면 성공적으로 권한을 받았다는 뜻이다.  
  
snapshot.connectionState를 실행하면 비동기 함수의 현재 실행 상태를 가져올 수 있다. 반환받을 수 있는 값은 다음 표와 
같다.  
  
![img.png](image2/img.png)  
  
위 표의 설명대로라면 !snapshot.hasData 대신에 snapshot.connectionState == ConnectionState.waiting을 사용할 수 
있어야 한다. ConnectionState.waiting은 로딩 상태를 의미하기 때문이다. 하지만 그렇게 코드를 작성하지 않았다. 이유는 
캐싱 떄문이다.  
  
캐싱은 데이터를 일시적으로 저장하고 기억하는 걸 의미한다. FutureBuilder는 제공된 비동기 함수의 상태가 변경될 때마다 
상위 builder() 함수가 재실행된다고 했다. 그런에 FutureBuilder는 다른 위젯과 마찬가지로 build() 함수에 영향을 받는다. 
build()가 다시 실행되면 FutureBuilder는 다시 렌더링되고 builder() 함수도 다시 실행된다. 그리고 그럴 때마다 비동기 
함수도 매번 다시 실행된다. 플러터에서는 무수히 많은 build() 함수를 실행한다. 이떄 매번 로딩 상태가 false로 돌아갔다가 
함수가 끝날 때 다시 true로 변하면 build()가 실행될 때마다 CircularProgressIndicator가 렌더링되어 화면에 깜빡임이 
생기게 된다. build() 함수에 기존 반환받았던 데이터값을 기억해두면 이 상황을 막을 수 있다. 그러면 같은 build() 함수가 
두 번 이상 실행될 때는 snapshot.connectionState가 ConnectionState.waiting이더라도 snapshot.data에서 기존 실행했던 
함수의 반환값을 받아볼 수 있다. 즉 화면이 깜빡거리는 현상을 막을 수 있다. 그래서 snapshot.connectionState 대신에 
snapshot.hasData를 사용해서 로딩 상태를 인지한다. (현재 저 코드는 깜빡임이 발생한다고 함. initState()에서 저장해야 
발생 안한다고 하는데 이유 파악 필요)  
  
5. 이제 아고라 API를 활성화시킬 차례이다. 활성화는 세 단계이다. 첫 번째로 아고라의 RtcEngine을 활성화해줘야 한다. 
활성화하면서 각종 이벤트를 받을 수 있는 콜백 함수도 설정한다. 두 번째로는 RtcEngine을 통해서 사용하는 핸드폰의 카메라를 
활성화해준다. 마지막으로는 미리 받아둔 아고라 API 상수값들을 사용해서 testchannel에 참여하면 된다.  
  
lib -> screen -> cam_screen.dart  
  
engine값이 null인지 확인하고 null이면 새로운 engine을 생성하는 로직을 실행한다. RtcEngineEventHandler는 RtcEngine에 
이벤트 콜백 함수들을 등록하는 함수이다. RtcEngineEventHandler 클래스를 사용하면 된다. onJoinChannelSuccess는 
채널에 입장했을 때 실행되는 함수이다. 채널에 입장한 상태면 uid 변수에 나의 고유 ID를 기억해둔다.  
- connection: 영상 통화 정보에 관련된 값. connection.localUid로 내 ID를 가져올 수 있다.  
- elapesd: joinChannel을 실행한 후 콜백이 실행되기까지 걸린 시간  
  
onLeaveChannel은 내가 채널에서 나갔을 때 실행되는 콜백 함수다. 채널에서 나갔으니 uid를 null로 변환한다.  
  
onUserJoined는 상대방이 채널에 입장했을 때 실행되는 함수이다. 상대방의 고유 ID를 otherUid 변수에 저장한다.  
- connection: 영상 통화 정보에 관련된 값. connection.localUid로 내 ID를 가져올 수 있다.  
- remoteUid: 상대방 고유 ID  
- elapsed: 내가 채널을 들어왔을 때부터 상대가 들어올 때까지 걸린 시간  
  
onUserOffline은 상대방이 채널에서 나갔을 때 실행되는 함수이다. otherUid 값을 null로 지정한다.  
- connection: 영상 통화 정보에 관련된 값. connection.localUid로 내 ID를 가져올 수 있다.  
- remoteUid: 상대방 고유 ID  
- reason: 방에서 나가게 된 이유(직접 나가기 또는 네트워크 끊김 등)  
  
채널 입장하기 코드에서 options 매개변수는 영상 송출과 관련된 여러 옵션을 상세하게 지정할 수 있지만 기본 설정을 사용한다. 
마지막 매개변수는 내 고유 ID를 지정하는 곳이다. 0을 입력하면 자동으로 고유 ID가 배정된다.  
  
6. testchannel에 참여하는 코드를 작성했지만 화면에 아직 아무것도 실행되지 않고 있다. 그 이유는 RtcEngine에서 송수신하는 
정보를 화면에 그려주는 코드를 아직 작성하지 않았기 때문이다. renderMainView()와 renderSubView() 함수를 작성해서 각각 
상대방의 화면과 내 화면을 보여준다.  
  
lib -> screen -> cam_screen.dart  
  
renderSubView는 내 핸드폰이 찍는 화면을 렌더링하는 함수이다. uid가 null이 아닐 때는 채널에 입장한 상태이니 AgoraVideoView의 
controller 매개변수에 VideoViewController()를 입력해서 내 핸드폰에서 찍는 화면을 보여준다.  
  
renderMainView는 상대방의 핸드폰에서 찍는 화면을 보여주는 역할을 한다. AgoraVideoView의 controller 매개변수에 
VideoViewController.remote()를 입력해줘서 상대의 화면을 보여준다.  
  
7. 이제 작성한 함수를 build() 함수에 입력해서 화면에 보여줄 차례이다. 동영상 플레이어 앱에서 사용했던 Stack 위젯을 
이용해서 상대방의 화면 위에 내 화면을 쌓는 방식으로 화면을 구현한다.  
  
lib -> screen -> cam_screen.dart  
  
8. 마지막으로 나가기 버튼을 설계한다. 뒤로 가기 기능은 내비게이션의 pop() 함수를 사용한다.  
  
lib -> screen -> cam_screen.dart  
  
# **핵심 요약**  
1. WebRTC는 현대에서 영상 통화에 가장 많이 사용하는 오픈 소스 프로토콜이다. 실시간으로 오디오 통화, 비디오 통신 그리고 
P2P 파일 공유를 할 수 있다.  
2. 내비게이션은 스크린을 전환할 때 사용하는 클래스이다.  
3. 아고라 API를 사용하면 WebRTC 기술이 잘 구현된 서비스를 이용할 수 있다.  
4. 카메라 권한과 마이크 권한을 받으면 동영상 촬영 기능을 구현할 수 있다. iOS에서의 권한은 Info.plist에서, 안드로이드에서 
권한은 android/app/src/main/AndroidManifest.xml에서 설정한다.  
  

  


  
