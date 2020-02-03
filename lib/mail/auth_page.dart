import 'package:flutter/material.dart';
import 'package:justcrew_flutter/firebase_provider.dart';
import 'package:justcrew_flutter/mail/signedin_page.dart';
import 'package:justcrew_flutter/mail/signin_page.dart';
import 'package:provider/provider.dart';

/*
<이메일과 비밀번호를 이용하여 Firebase에 로그인하는 메커니즘>

1. 메일 주소와 비밀번호로 회원가입
2. 회원가입에 성공하면 인증메일 발송
3. 인증메일 링크를 통해 메일 주소 인증
4. 메일 주소 인증이 완료된 경우에 한해서만 로그인 성공

<구글 계정을 이용한 Firebase 로그인 메커니즘>
1. 구글 계정을 통해 로그인 시도
2. 성공 시 회원가입 및 로그인 완료, 메일 주소 인증 불필요

 */

AuthPageState pageState;

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() {
    pageState = AuthPageState();
    return pageState;
  }
}

class AuthPageState extends State<AuthPage> {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    logger.d("AuthPageStateAuthPageState user: ${fp.getUser()}");
    if (fp.getUser() != null && fp.getUser().isEmailVerified == true) {
      return SignedInPage();
    } else {
      return SignInPage();
    }
  }
}