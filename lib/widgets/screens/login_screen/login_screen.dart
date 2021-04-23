import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mongol_ebook/Api%20Manager/api_manager.dart';

class LoginPage extends StatelessWidget {
  final usernameText = TextEditingController();
  final passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'ZmongolBook',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      inputFile(
                          label: "Username", textController: usernameText),
                      inputFile(
                          label: "Password",
                          obscureText: true,
                          textController: passwordText)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        ApiManager.logIn(usernameText.text, passwordText.text)
                            .then((value) {
                          if (value.contains('successful')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("LogIn Successful")));
                            Navigator.of(context).pushReplacementNamed('/home');
                          } else if (value.contains('incorrect')) {
                            // showToast('Incorrect username/password');
                             ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text("Login failed")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Failure")));
                          }
                        });
                      },
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      SignInButtonBuilder(
                          backgroundColor: Colors.blueGrey,
                          onPressed: () {
                            Navigator.of(context).pushNamed('/signup');
                          },
                          text: 'SignUp With Phone'),
                      SignInButton(
                        Buttons.FacebookNew,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

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

// we will be creating a widget for text field
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
