import 'package:chapter21/component/login_text_field.dart';
import 'package:chapter21/const/colors.dart';
import 'package:chapter21/provider/schedule_provider.dart';
import 'package:chapter21/screen/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final provider = context.watch<ScheduleProvider>();

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
                onPressed: () {
                  onRegisterPress(provider);
                },
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
                onPressed: () {
                  onLoginPress(provider);
                },
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

  onRegisterPress(ScheduleProvider provider) async {
    // 미리 만들어둔 함수로 form을 검증한다
    if(!saveAndValidateForm()){
      return;
    }

    // 에러가 있을 경우 값을 이 변수에 저장한다
    String? message;

    try{
      // 회원가입 로직을 실행한다
      await provider.register(
          email: email,
          password: password,
      );
    } on DioError catch (e) {
      // 에러가 있을 경우 message 변수에 저장한다 만약 에러 메시지가 없다면
      // 기본값을 입력한다
      message = e.response?.data['message'] ?? '알 수 없는 오류가 발생했습니다.';
    } catch (e) {
      message = '알 수 없는 오류가 발생했습니다.';
    } finally {
      // 에러 메시지가 null이 아닐 경우 스낵바 값을 담아서 사용자에게 보여준다
      if(message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }else{
        // 에러가 없을 경우 홈 스크린으로 이동한다
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
      }
    }
  }

  onLoginPress(ScheduleProvider provider) async {
    if(!saveAndValidateForm()){
      return;
    }

    String? message;

    try{
      // register() 함수 대신에 login() 함수를 실행한다
      await provider.login(
        email: email,
        password: password
      );
    } on DioError catch(e) {
      // 에러가 있을 경우 message 변수에 저장한다. 만약 에러 메시지가 없다면
      // 기본값을 입력한다
      message = e.response?.data['message'] ?? '알 수 없는 오류가 발생횄습니다.';
    } catch (e) {
      message = '알 수 없는 오류가 발생했습니다.';
    } finally {
      if(message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }else{
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
      }
    }
  }
}