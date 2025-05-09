import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chapter21/const/colors.dart';

class LoginTextField extends StatelessWidget {
  final FormFieldSetter<String?> onSaved;
  final FormFieldValidator<String?> validator;
  final String? hintText;
  final bool obscureText;

  const LoginTextField({
    required this.onSaved,
    required this.validator,
    this.obscureText = false,
    this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // 텍스트 필드값을 저장할 때 실행할 함수
      onSaved: onSaved,
      // 텍스트 필드값을 검증할 때 실행할 함수
      validator: validator,
      cursorColor: SECONDARY_COLOR,
      // 텍스트 필드에 입력된 값이 true일 경우 보이지 않도록 설정
      // 비밀번호 텍스트 필드를 만들 때 유용하다
      obscureText: obscureText,
      decoration: InputDecoration(
        // 텍스트 필드에 아무것도 입력하지 않았을 때 보여주는 힌트 문자
        hintText: hintText,
        // 활성화된 상태의 보더
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: TEXT_FIELD_FILL_COLOR,
          ),
        ),
        // 포커싱된 상태의 보더
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: SECONDARY_COLOR,
          ),
        ),
        // 에러 상태의 보더
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: ERROR_COLOR,
          ),
        ),
        // 포커스된 상태에서 에러가 났을 때 보더
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: ERROR_COLOR,
          ),
        ),
      ),
    );
  }
}