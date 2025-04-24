# **포토 스티커(GestureDetector)**  
# **프로젝트 구상하기**  
제스처 기능 및 위젯의 위치를 조절하는 방법을 알아본다. 지금까지 버튼을 이용해서 탭 제스처만 사용해왔다. 플러터에서는 
단순히 탭 제스처뿐만 아니라 굉장히 넓은 스펙트럼의 제스처들을 손쉽게 사용하도록 해준다. 이번에 배워볼 onScaleUpdate 
제스처는 확대, 축소 및 x, y, z축에서의 이동에 대한 정보도 모두 받아볼 수 있다.  
  
제스처의 움직임을 받고 나면 제스처의 움직임만큼 위젯 위치와 크기를 조절해줘야 한다. 이 기능을 플러터에서 제공하는 
Transform 위젯을 사용하면 간편하게 구현할 수 있다.  
  
# **사전 지식**  
# **GestureDetector와 제스처**  
GestureDetector는 플러터에서 지원하는 모든 제스처들을 구현할 수 있는 위젯이다. 지금까지 사용해본 단순 탭뿐만 아니라 
더블 탭, 길게 누르기, 드래그 등 여러 가지 제스처를 인식할 수 있다. 제스처가 인식되면 매개변수에 입력된 콜백 함수가 
실행된다. 다음 표에 흔히 사용되는 제스처 매개변수들이 정리되어있다.  
  
![img.png](image/img.png)  
  
# **사전 준비**  
이미지를 불러오고 저장하려면 사진첩 및 파일시스템 관련 권한이 필수이다.  
  
1. 실습에 사용할 프로젝트 생성  
- 프로젝트 이름: image_editor  
- 네이티브 언어: 코틀린  
  
# **이미지와 폰트 추가하기**  
1. asset 폴더를 만들고 그 아래 img 폴더를 만든다. 내려받은 이미지를 img 폴더에 저장한다.  
  
# **pubspec.yaml 설정하기**  
1. 다음 수정 사항을 pubspec.yaml에 적용한다.  
  
![img.png](image/img2.png)  
  
2. pub get을 실행해서 변경 사항을 저장한다.
  
# **네이티브 권한 설정하기**  
# **iOS 권한 설정하기**  
iOS는 이미지 관련 권한을 추가해야 한다. 사진첩(NSPhotoLibraryUsageDescription), 카메라(NSCameraUsageDescription), 
마이크(NSMicrophoneUsageDescription) 권한을 추가한다.  
  
ios -> Runner -> Info.plist  
  
# **안드로이드 권한 설정하기**  
안드로이드 11 버전을 기준으로 새로운 파일 저장소가 추가되었다. 하지만 사용자의 핸드폰이 안드로이드 11 버전 이전 운영체제를 
실행 중이면 기존 파일 저장소를 사용해야 하기 때문에 requestLegacyExternalStorage 옵션을 true로 설정해줘야 한다. 
이 값을 true로 설정하면 모든 버전에서 적절한 파일 저장소를 사용할 수 있다.  
  
android -> app -> src -> main -> mainAndroidManifest.xml  
  
# **프로젝트 초기화하기**  
1. lib 폴더에 screen 폴더를 생성하고 앱의 기본 홈 화면으로 사용할 HomeScreen 위젯을 생성할 home_screen.dart를 생성한다. 
  
lib -> screen -> home_screen.dart  
  
2. lib/main.dart 파일에서도 마찬가지로 HomeScreen을 홈 위젯으로 등록해준다.  
  
lib -> main.dart  
  
# **레이아웃 구상하기**  
이번 프로젝트는 하나의 스크린으로 구성되어 있다. HomeScreen을 최상단 AppBar, 이미지를 보여주는 중앙 Body, 스티커를 
고르는 Footer로 3등분으로 나눠서 구현한다.  
  
# **홈 스크린 위젯**  
이번 프로젝트는 하나의 스크린으로 구성되어 있다. 하지만 이미지가 선택됐을 때와 이미지가 선택되지 않았을 떄의 화면이 약간 
다르다. 이미지가 선택되지 않은 상태에서는 화면의 중앙에 [이미지 선택하기] 버튼이 보인다. 반면 이미지가 선택된 상태에서는 
선택된 이미지와 스티커를 고를 수 있는 패널이 생긴다.  
  
![img.png](image/img3.png)  
  
# **이미지 선택 후 화면**  
이미지를 선택한 후 보이는 화면을 세 가지 요소로 요약할 수 있다.  
  
첫 번쨰로 AppBar이다. 반투명 형태로 이미지가 AppBar 아래에 위치하도록 설계할 계획이니 일반 AppBar 위젯을 사용하지 않고 
직접 Container를 이용해서 AppBar를 구현한다. 두 번째는 선택한 이미지가 보이는 Body이다. 이 이미지는 화면 전체를 차지하고 
전체 화면 위에 AppBar와 스티커를 고를 수 있는 Footer 위젯이 올라가게 된다. 추가적으로 이 이미지 위에 쌓을 수 있어야 
한다. 더 나아가 섬세하게 스티커들을 위치시키도록 이미지를 이동하고 확대할 수 있어야 한다.  
  
마지막으로 Footer이다. Footer는 꾸밀 이미지를 선택했을 때만 화면에 보이는 위젯으로 스티커 목록을 보여주는 공간이다. 
좌우로 스크롤이 가능하고 원하는 스티커를 탭했을 때 이미지 위에 스티커를 올릴 수 있다.  
  
![img.png](image/img4.png)  
  
# **구현하기**  
UI부터 구현한다. 이미지를 선택하는 화면을 제외한 나머지 화면은 HomeScreen에서 작업하면 된다. HomeScreen UI 작업이 
끝나면 스티커 붙이기 기능을 구현하고 마지막으로 이미지 선택, 이모티콘 삭제, 이미지 저장에 해당되는 기능을 구현한다.  
  
# **AppBar 구현하기**  
1. AppBar를 구현한다. lib/component/main_app_bar.dart 파일을 만들고 MainAppBar StatelessWidget을 구현한다.  
  
lib -> component -> main_app_bar.dart  
  
첫 번째로 IconButton 3개를 Row 위젯에 감싸서 MainAxisAlignment.spaceAround를 적용한다. 이 IconButton들은 
각각 왼쪽부터 [이미지 선택] 버튼, [스티커 삭제] 버튼, [이미지 저장] 버튼을 담당한다. 상태 관리는 MainAppBar 위젯을 
사용할 HomeScreen에서 수행하므로 버튼 순서대로 onPressed 매개변수를 각각 onPickImage, onSaveImage, onDeleteItem 
이름으로 외부에서 입력받는다.  
  
2. 구현한 MainAppBar 위젯을 HomeScreen 위젯에 위치시킨다. MainAppBar 위젯과 Footer 위젯을 Body 위젯 위에 올려야 하니 
위젯을 위로 쌓을 수 있는 Stack 위젯을 이용해서 배치한다.  
  
lib -> screen -> home_screen.dart  
  
Stack 위젯의 fit 매개변수에는 StackFit을 입력할 수 있다. StackFit은 StackFit.loose와 StackFit.expand가 존재한다. 
StackFit.loose는 자식들이 최소한의 크기만 차지하도록 하고 StackFit.expand는 자식들이 차지할 수 있는 공간의 최대한 
크기를 차지하도록 한다.  
  
3. 실행하면 MainAppBar가 최상단에 위치한다.  
  
# **Image 선택하기**  
1. HomeScreen 위젯에서는 상태 관리를 해줘야 하므로 StatelessWidget에서 StatefulWidget으로 변경한다. 그리고 선택한 
이미지를 저장할 image 변수를 선언하고 onPickImage() 함수가 실행됐을 때 이미지를 선택하면 image 변수에 선택한 값을 
저장한다. 이미지를 선택하는 창을 사용자에게 보여주는 방법은 매우 간단하다. ImagePicker 패키지를 사용하면 된다. 동영상 
플레이어 앱에서는 pickVideo() 함수를 사용했지만 이번에는 pickImage() 함수를 사용해서 이미지를 고른다.  
   
lib -> screen -> home_screen.dart  

ImageSource.gallery를 선택하면 갤러리에서 직접 이미지를 고를 수 있고 ImageSource.camera를 선택하면 사용할 이미지를
카메라로 직접 찍을 수 있다.

2. ImagePicker 플러그인은 네이티브 코드를 사용하는 플러그인이니 꼭 앱을 종료했다가 다시 시작해서 새로 구현한 함수를
테스트해야 한다. 재시작 후 이미지 선택 아이콘을 누르면 이미지를 선택하는 창이 보인다.  
  
# **Body 구현하기**  
1. Body는 한 가지 조건에 의해 두 가지 UI가 렌더링돼야 한다. 첫 번째는 이미지가 선택되지 않은 상태에는 [이미지 선택하기] 
라고 적힌 버튼을 화면 중앙에 보여줘야 한다. 두 번째는 이미지가 선택된 상태일 때는 선택된 이미지를 화면에 보여줘야 한다. 
추가로 위젯을 확대하고 좌우로 이동할 수 있는 InteractiveViewer로 Image 위젯을 감싸서 Image 위젯에 자동으로 제스처 
기능이 적용되게 한다.  
   
lib -> screen -> home_screen.dart (책 주석 부분 fit과 Positioned 위젯 주석하면 안됨)  
  
2. 변경 사항을 저장해서 핫 리로드를 실행한 후 이미지를 선택하면 화면에 선택한 이미지가 보인다. 확대 제스처나 축소 
제스처를 했을 때 Image 위젯을 확대하거나 축소할 수 있고 확대된 상태에서는 이미지를 좌우, 상하로 이동할 수 있다. 시뮬레이터와 
에뮬레이터에서는 macOS에서 CMD, 윈도우에서 Ctrl 키를 누른 후 화면에 마우스를 클릭하고 드래그해서 확대 및 축소 제스처를 
적용할 수 있다.  
  
# **Footer 구현하기**  
1. 이미지가 선택되고 나면 이미지에 올릴 스티커를 고르는 Footer 창이 필요하다. Footer 윚세 또한 MainAppBar 위젯에서처럼 
lib/component/footer.dart 파일에 정의한다.  
  
lib -> component -> footer.dart  
  
이미 내려받은 asset/img 폴더에 있는 모든 이모티콘들을 Row 위젯 안에 구현한다. 그리고 SingleChildScrollView 위젯으로 
감싸서 가로로 스크롤하도록 설정한다. 마지막으로 각 스티커가 눌릴 때마다 실행할 OnEmotionTap() 함수를 정의한다. 그다음 
GestureDetector 위젯으로 각 이모티콘 이미지를 감싼 다음 onTap() 함수가 실행될 때마다 onEmoticonTap() 함수를 실행해서 
몇 번째 이모티콘이 탭 됐는지 상위 위젯으로 전달해준다.  
  
2. Footer 위젯을 HomeScreen 위젯에 위치시킨다.  
  
lib -> screen -> home_screen.dart  
  
MainAppBar 위젯과 Footer 위젯은 Body 위에 위치해야 하니 Stack 위젯의 가장 첫 번쨰에 renderBody() 함수를 입력해주고 
MainAppBar 위젯과 Footer 위젯을 그 아래에 위치시킨다. 더 나아가 Footer 위젯은 화면의 아래에 위치해야 하므로 Positioned 
위젯으로 감싸서 화면의 가장 아래에 배치한다. 마지막으로 Footer 위젯은 이미지가 선택된 상태에서만 보여야 하기 떄문에 
image 변수가 null일 때만 렌더링되도록 조건문을 사용한다.  
  
3. 코드를 저장한 후 핫 리로드해서 반영하면 이미지가 선택된 상태에서 좌우로 스크롤 가능한 스티커를 고를 수 있는 Footer 
위젯이 생긴 것을 확인할 수 있다.  
  
# **EmoticonSticker 위젯 구현하기**  
이제 이모티콘 스티커를 이미지에 붙이는 기능을 만들어야 한다. Footer 위젯에서 이모티콘을 탭하면 이미지 위에 선택한 
이모티콘이 올려지고 이모티콘을 드래그해서 이동하거나 크기를 변경했을 때 화면에 적절히 반영돼야 한다.  
  
1. lib/component/emoticon_sticker.dart 파일을 생성해 기능을 구현한다.  
  
lib -> component -> emoticon_sticker.dart  
  
먼저 EmoticonSticker StatefulWidget을 선언한다. 다음으로 보여줄 스티커의 경로를 외부에서 입력받아서 Image 위젯에 
입력한다. 그리고 이미지를 GestureDetector 위젯으로 감싸서 onTap, onScaleUpdate, onScaleEnd 매개변수를 지정한다. 
마지막으로 onScaleUpdate와 onTap 매개변수가 실행됐을 때 스티커 상태가 변경이 된다는 걸 부모 위젯에 알리는 onTransform() 
함수를 정의하고 실행한다.  
  
2. 제스처를 입력받아보는 기능을 구현한다. 첫 번째는 onScaleUpdate 제스처다. 이 제스처는 ScaleUpdateDetails 값을 첫 번째 
매개변수로 입력받는다. ScaleUpdateDetails는 굉장히 많은 정보를 제공한다. 여기서 사용할 정보는 두 가지다. 첫 번째로 확대 
배율에 해당되는 details.scale이다. 이 값은 double 값으로 제공되며 확대/축소 제스처가 시작된 순간을 기준으로 몇 배율의 
변화가 있는지 알려준다. 배율은 위젯의 초기 크기 기준이 아니기 때문에 확대/축소 제스처가 끝나는 순간을 알려주는 onScaleEnd 
매개변수가 실행될 때 현재 배율을 꼭 기억해두어야 한다. 그래야 최근 비율 * details.scale을 계산해서 위젯의 초기 크기 
기준으로 배율을 계산할 수 있다. 두 번째로 사용할 값은 details.focalPointDelta이다. 이 값은 dy값 및 dx값을 갖고 
있으며 각각 y축 및 x축으로 이동한 수치를 반환받을 수 있다. 가로와 세로로 이동한 수치와 확대 및 축소가 된 수치를 변수로 
저장해두고 확대/축소 제스처에 대한 콜백이 실행될 때마다 변수들을 업데이트해주면 사용자가 의도한 위젯의 변화를 상태 관리할 
수 있다.  
  
lib -> component -> emoticon_sticker.dart  
  
확대/축소 제스처가 끝나는 순간의 배율을 기억한다. 새로 제스처가 감지될 때 반환되는 배율과 이 배율을 곱해서 위젯의 실제 
초기 크기 대비 배율을 계산한다. 현재 제스처가 시작된 순간 기준으로 변경된 배율과 마지막 제스처의 배율을 곱해서 실제 배율을 
계산한다. x와 y축을 기준으로 이동된 만큼 값을 각각 hTransform과 vTransform에 더해서 좌표를 이동시킨다.  
  
3. 이모티콘 스티커 여러 개를 이미지 하나에 추가한다. 따라서 현재 어떤 이모티콘 스티커가 선택되어 있는지 확인할 수 있어야 
삭제 또는 이동 및 확대/축소 기능을 제공할 수 있다. 이모티콘이 선택된 상태인지 지정하는 isSelected 변수를 선언하고 
외부에서 입력받아서 이 값이 true면 파란색 테두리를 만든다.  
  
lib -> component -> emoticon_sticker.dart  
  
4. 위젯의 움직임 및 확대/축소는 감지를 하고 있지만 아직 이 변화를 위젯에 반영하고 있지 않다.  
  
lib -> component -> emoticon_sticker.dart  
  
Transform 위젯을 사용해 자식 위젯의 위치 및 확대/축소 배율을 변경할 수 있다. Transform 위젯의 transform 매개변수에는 
매트릭스값을 넣어서 자식 위젯의 변화를 정의한다. 단위 행렬을 하나 선언하고 좌우 또는 상하의 움직임을 translate() 
함수로 정의하고 확대/축소를 scale() 함수로 정의한다.  
  
# **스티커 붙이기**  
1. 이제 스티커 붙이기 기능을 구현해야 한다. 여러 개의 스티커를 한꺼번에 관리하기 편하도록 lib/model/sticker_model.dart 
파일에 StickerModel 클래스를 구현해서 각각 스티커에 필요한 정보를 저장한다. 현재 필요한 각각 스티커의 정보는 유일한 
ID 값과 스티커 이미지의 경로이다. Map을 사용해서도 편하게 구현할 수 있으나 Map을 사용할 경우 데이터 구조가 강제되지 
않아서 상태 관리를 할 때는 꼭 클래스를 사용해서 데이터를 구조화하는 게 좋다.  
  
lib -> model -> sticker_model.dart  
  
operator == 는 하나의 인스턴스가 다른 인스턴스와 같은지 비교할 때 사용된다. StickerModel은 id에 유일한 값을 입력하고 
만약에 겹치면 중복 데이터를 제거한다. get은 세트 등 해시값을 사용하는 데이터 구조에서 사용하는 게터이다. 마찬가지로 
id 값만 유일하면 되니 id의 hashCode 값만 반환해준다.  
  
2. 화면에 붙여줄 스티커들을 Set<StrickerModel>로 관리해주면 쉽게 상태 관리가 가능해진다. 각각 StickerModel을 기바으로 
화면에 EmoticonSticker 위젯을 렌더링할 수 있는 코드를 작성한다. 추가적으로 어떤 스티커가 선택되어 있는 상태인지 구분할 
수 있는 selectedId 변수를 선언해서 선택된 스티커의 id를 저장한다.  
  
lib -> screen -> home_screen.dart  
  
StatefulWidget을 사용할 때 같은 위젯 여러 개를 리스트로 제공하려면 각각 위젯을 구분하는 key 매개변수를 지정해줘야 한다. 
이 값이 같으면 같은 위젯으로 인식하고 다르면 다른 위젯으로 인식한다.  
  
3. 이제 Footer 위젯에서 각 스티커를 누를 때마다 stickers 변수를 업데이트해주며 된다. 스티커를 누를 때마다 새로운 
StickerModel을 stickers 변수에 입력한다.  
  
lib -> screen -> home_screen.dart  
  
UUID 패키지의 Uuid().v4() 함수를 사용하면 절대로 겹치지 않는 String 값을 생성해낼 수 있다. 화면에 스티커를 생성할 
때마다 유일한 id값을 소유하는 StickerModel을 만들어야 하니 id값에 매번 새로운 UUID 값을 생성해서 저장한다.  
  
4. selectedId 변수를 선언해두었지만 어디서도 사용하고 있지 않다. 이 변수는 특정 스티커를 탭하거나 위치가 변경되거나 
확대/축소가 변경됐을 때 현재 조작 중인 스티커의 ID로 지정돼야 한다. 마침 EmotionSticker 위젯에 onTransform() 함수를 
입력해두었으니 이 함수에서 selectedId값을 지정해준다.  
  
lib -> screen -> home_screen.dart  
  
5. 프로젝트를 저장하고 핫 리로드해서 Footer의 첫 번재 이모티콘을 누르면 이미지 위에 이모티콘 스티커가 위치한다. 해당 
이모티콘을 누르거나 확대/축소 비율을 조절하거나 위치를 이동하면 이모티콘 이미지 주위에 파란색 테두리가 생기며 현재 선택된 
이모티콘이라는 표시가 된다.  
  
# **스티커 삭제하기**  
1. 스티커 붙이기 기능이 잘 구현되었으니 이제 스티커를 삭제하는 기능을 추가해야 한다. 스티커 삭제 버튼은 이미 MainAppBar 
위젯에 구현해놨으니 onDeleteItem() 함수만 작업해주면 된다. Set 형태인 stickers 변수에 모든 스티커 정보를 다 저장해놨으니 
스티커 삭제 버튼이 눌릴 때마다 stickers 변수에서 각 StrickerModel을 순회하며 id를 비교해서 selectedId 변수에 해당하는 
값을 지워주면 된다.  
  
lib -> screen -> home_screen.dart  
  


