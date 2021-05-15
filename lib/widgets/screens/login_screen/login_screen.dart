import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Helper/AppStyles.dart';
import 'package:mongol_ebook/network/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mongol/mongol.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final apiService = ApiService(Dio(), BASE_URL + ":8080");
  final usernameText = TextEditingController();
  final passwordText = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late bool userLogged;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    logIn();
  }

  void logIn() {
    isLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        //   FirebaseMessaging.instance.getToken().then((token) {
        //   print("Firebase Token: " + token.toString());
        //   ApiManager.sendToken(prefs.getString(USERNAME)!, token.toString())
        //       .then((value) {
        //     if (value.contains("success")) {
        //       print("Send token response: " + value);
        //       showToast('Notifications Subscribed');
        //     }
        //   });
        // });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2), content: Text("loging in 正在登陆")));
        Future.delayed(const Duration(seconds: 2), () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.of(context).pushReplacementNamed('/home');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(40.0),
              shrinkWrap: true,
              children: [
                Center(
                  child: MongolText(
                    'Z ᢌᡭᡪᢊᡱᡱᡭᢐ',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 45, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "ᡯᡪᡳᢙᡪᢞᡪᢊᡪᡭᡧ ᡥᡭᡪᢊᢔᡬᡱᡱᡪᢞᡪᡫ Please login to continue 请先登陆",
                  style: TextStyle(fontFamily: 'haratig', fontSize: 16, color: Colors.grey[800]),
                ),
                SizedBox(
                  height: 32.0,
                ),
                _inputField(
                  controller: usernameText,
                  label: "ᡯᡪᢝᡨ user name 用户姓名",
                ),
                SizedBox(
                  height: 16.0,
                ),
                _inputField(
                  controller: passwordText,
                  label: "ᡯᡬᡱᡱᡭᢚᡧ ᢙᡭᡱᡱᡪᢝ password 密码",
                  obscureText: true,
                ),
                SizedBox(
                  height: 24.0,
                ),
                _button(
                  label: "ᡯᡪᡳᢙᡪᢞᡪᢋᡭ login 登陆",
                  onTap: _tryLogin,
                  btnColor: Colors.green[700]!,
                  textColor: Color(SOFT_WHITE),
                ),
                SizedBox(
                  height: 32.0,
                ),
                _forgotPassword(),
                SizedBox(
                  height: 16.0,
                ),
                _textRegister(),
                // SizedBox(
                //   height: 48.0,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Divider(),
                //     ),
                //     Text('or'),
                //     Expanded(
                //       child: Divider(),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 48.0,
                ),
                _button(
                  label: "ᢘᡪᡪᢊᢔᡪᢑᡪᡪᡪᡳ Register 注册",
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  btnColor: Color(SOFT_BLACK),
                  textColor: Color(SOFT_WHITE),
                ),
                SizedBox(
                  height: 12.0,
                ),
                _button(
                  label: "ᢡᡪᡬᡬᢔᡴᡭᢣ ᡬᡬᡪᢝ ᡯᡪᡳᢙᡪᢞᡪᢋᡭ Facebook login 脸书登陆",
                  leading: SvgPicture.asset(
                    "assets/icon/facebook.svg",
                    color: Colors.white,
                    height: 20.0,
                    width: 20.0,
                  ),
                  onTap: () => null,
                  btnColor: Color(FACEBOOK_COLOR),
                  textColor: Color(SOFT_WHITE),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(
      {TextEditingController? controller,
      String? label,
      bool obscureText = false}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 4.0,
            spreadRadius: 0.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration.collapsed(
          hintText: label,
        ),
      ),
    );
  }

  Widget _button(
      {required String label,
      required VoidCallback onTap,
      required Color btnColor,
      required Color textColor,
      Widget? leading}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: btnColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 12.0,
            spreadRadius: 4.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            leading != null
                ? Container(
                    child: leading,
                    margin: EdgeInsets.only(right: 8.0),
                  )
                : Container(),
            Text(
              label,
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    return Text(
      "ᡯᡬᡱᡱᡭᢚᡧ ᢙᡭᡱᡱᡪᢝ ᡬᡬᡪᡧ ᢌᡪᢞᢙᡪᡪᡪᢔᡪᡧ Forgot your password 忘记密码?",
      textAlign: TextAlign.center,
      style: TextStyle(fontFamily: 'haratig', color: Color(SOFT_BLACK), fontWeight: FontWeight.w300),
    );
  }

  Widget _textRegister() {
    return GestureDetector(
      onTap: null,
      child: Text(
        "ᡯᡪᡳᢙᡪᢞᡪᢋᡭ ᢙᡭᡱᡱᡪᢝ ᡥᡭᡬᢊᡪᡫ ᡳᡪᡬᡬᡪᡪᢔᡪᡱᡱᡪᢝ Do not have an account 没有账号?",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'haratig', color: Color(SOFT_BLACK), fontWeight: FontWeight.w300),
      ),
    );
  }

  _tryLogin() async {
    var result = await apiService.login(usernameText.text, passwordText.text);

    if (result.success) {
      saveAccessToken(result.accessToken!);
      logIn();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.errorMessage!)));
    }
  }

  saveAccessToken(String token) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(PREFS_ACCESS_TOKEN, token);
  }

  Future<bool> isLoggedIn() async {
    prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREFS_ACCESS_TOKEN) != null;
  }

  // Future<void> fbLogin(BuildContext ctx) async {
  //   final LoginResult result = await FacebookAuth.instance
  //       .login(); // by the fault we request the email and the public profile
  //   if (result.status == LoginStatus.success) {
  //     // you are logged
  //     final AccessToken accessToken = result.accessToken!;
  //     print('FB access token: ' + accessToken.token);
  //     ScaffoldMessenger.of(ctx)
  //         .showSnackBar(SnackBar(content: Text("LogIn Successful")));
  //     saveUser();
  //     Future.delayed(const Duration(seconds: 2), () {
  //       ScaffoldMessenger.of(context).removeCurrentSnackBar();
  //       Navigator.of(context).pushReplacementNamed('/home');
  //     });
  //   }
  // }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Widget inputFile({label, obscureText = false, textController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          controller: textController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBDBDBD)),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD)))),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
