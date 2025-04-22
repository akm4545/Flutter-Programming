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
  

  
