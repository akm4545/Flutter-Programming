import 'package:chapter21/component/login_text_field.dart';
import 'package:chapter21/const/colors.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Form을 제어할 때 사용되는 GlobalKey다. 이 값을 제어하고 싶은
  // Form의 key 매개변수에 입력해주면 된다.
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Form을 저장했을 때 이메일을 저장할 프로퍼티
  String email = '';

  // Form을 저장했을 때 비밀번호를 저장할 프로퍼티
  String password = '';

  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 깔끔한 디자인을 위해 좌, 우로 패딩을 준다
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            // 세로로 중앙 배치한다
            mainAxisAlignment: MainAxisAlignment.center,
            // 가로로 최대한의 크기로 늘려준다
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 로고를 화면 너비의 절반만큼의 크기로 렌더링하고 가운데 정렬한다
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/img/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              const SizedBox(height: 16.0),
              // 로그인 텍스트 필드
              // TextFormField(),
              LoginTextField(
                // 추후 회원가입/로그인 로직을 작성할 때 사용된다
                onSaved: (String? val) {
                  email = val!;
                },
                // Form의 validate() 함수를 실행하면 입력값을 확인한다
                validator: (String? val) {
                  // 이메일이 입력되지 않았으면 에러 메시지를 반환한다
                  if(val?.isEmpty ?? true){
                    return '이메일을 입력해주세요.';
                  }

                  // 정규표현식을 이용해 이메일 형식이 맞는지 검사한다
                  RegExp reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                  // 이메일 형식이 올바르지 않게 입력됐다면 에러 메시지를 반환한다
                  if(!reg.hasMatch(val!)){
                    return '이메일 형식이 올바르지 않습니다.';
                  }

                  // 입력값에 문제가 없다면 null을 반환한다
                  return null;
                },
                // 텍스트 필드에 어떤 값도 입력되지 않은 경우 이메일이라는
                // 힌트 텍스트를 보여준다
                hintText: '이메일',
              ),
              const SizedBox(height: 16.0),
              LoginTextField(
                // 비밀번호를 입력할 때 보안을 위해 특수문자로 가려준다
                obscureText: true,
                onSaved: (String? val) {
                  password = val!;
                },
                validator: (String? val) {
                  // 비밀번호가 입력되지 않았다면 에러 메시지를 반환한다
                  if(val?.isEmpty ?? true) {
                    return '비밀번호를 입력해주세요.';
                  }

                  // 입력된 비밀번호가 4자리에서 8자리 사이인지 확인한다
                  if(val!.length < 4 || val.length > 8) {
                    return '비밀번호는 4~8자 사이로 입력해주세요!!';
                  }

                  // 입력값에 문제가 없다면 null을 반환한다
                  return null;
                },
                hintText: '비밀번호',
              ),
              // 회원가입 버튼
              ElevatedButton(
                // 버튼 배경 색상 로고 색으로 변경
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: SECONDARY_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {},
                child: Text('회원가입'),
              ),
              // 로그인 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: SECONDARY_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                onPressed: () async {},
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool saveAndValidateForm() {
    // form을 검증하는 함수를 실행한다
    if(!formKey.currentState!.validate()){
      return false;
    }

    // form을 저장하는 함수를 실행한다.
    formKey.currentState!.save();

    return true;
  }
}