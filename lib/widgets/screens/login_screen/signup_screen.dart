import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Model/auth/register_result.dart';
import 'package:mongol_ebook/network/api_service.dart';
import 'package:mongol/mongol.dart';

class SignupPage extends StatelessWidget {
  final apiService = ApiService(Dio(), BASE_URL + ":8080");
  final usernameText = TextEditingController();
  final passwordText = TextEditingController();
  final confirmPasswordText = TextEditingController();
  final emailText = TextEditingController();
  final firstNameText = TextEditingController();
  final lastNameText = TextEditingController();
  // final phoneText = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    MongolText(
                      "ᡴᡭᡬᢞᡬᡭᡪᢊᡪᢋᡭ",
                      style: TextStyle(
                        fontFamily: 'z52ordostig',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "ᠨᠡᠷ᠎ᠡ ᠪᠡᠨ ᠪᠦᠷᠢᠳᠬᠡᠭᠡᠷᠡᠢ Create an account 注册用户",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: [
                    inputFile(
                      label: "ᠨᠡᠷ᠎ᠡ Username 用户名",
                      textController: usernameText,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "ᠨᠡᠷ᠎ᠡ ᠪᠡᠨ ᠪᠢᠴᠢᠭᠡᠷᠡᠢ Username is required 需要用户名";
                        }

                        if (val.length < 4) {
                          return "ᠳᠦᠷᠪᠡ ᠡᠴᠡ ᠤᠷᠲᠤ ᠨᠡᠷ᠎ᠡ ᠪᠢᠴᠢᠭᠡᠷᠡᠢ Username has to be at least 4 characters long.用户名最短是4位";
                        }
                      },
                    ),
                    inputFile(
                      label: "ᠨᠢᠭᠤᠴᠠ  ᠳ᠋ᠤᠭᠠᠷ Password 密码",
                      obscureText: true,
                      textController: passwordText,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "ᠨᠢᠭᠤᠴᠠ  ᠳ᠋ᠤᠭᠠᠷ  ᠬᠡᠷᠡᠭᠲᠡᠢ Password is required 需要密码";
                        }

                        if (val.length < 8) {
                          return "ᠨᠢᠭᠤᠴᠠ  ᠳ᠋ᠤᠭᠠᠷ 8  ᠡᠴᠡ ᠤᠷᠲᠤ ᠪᠠᠶ᠋ᠢᠬᠤ Password has to be at least 8 characters long.";
                        }
                      },
                    ),
                    inputFile(
                      label: "ᠨᠢᠭᠤᠴᠠ  ᠳ᠋ᠤᠭᠠᠷ ᠵᠢᠠᠨ ᠳᠠᠪᠲᠠᠬᠤ Confirm Password 确认密码",
                      obscureText: true,
                      textController: confirmPasswordText,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "ᠨᠢᠭᠤᠴᠠ  ᠳ᠋ᠤᠭᠠᠷ ᠵᠢᠠᠨ ᠳᠠᠪᠲᠠᠬᠤ  ᠬᠡᠷᠡᠭᠲᠡᠢ Confirm Password is required 需要确认密码";
                        }

                        if (val != passwordText.text) {
                          return "ᠳᠠᠪᠲᠠᠬᠤ  ᠳ᠋ᠤᠭᠠᠷ ᠠᠳᠠᠯᠢ ᠪᠠᠶ᠋ᠢᠬᠤ Confirm Password and Password have to be the same 确认密码必须同一";
                        }
                      },
                    ),
                    inputFile(
                      label: "ᠢᠮᠡᠸᠯ Email 邮箱",
                      textController: emailText,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "ᠢᠮᠡᠸᠯ ᠬᠡᠷᠡᠭᠲᠡᠢ Email is required 需要邮箱";
                        }
                      },
                    ),
                    inputFile(
                      label: "ᠨᠡᠷ᠎ᠡ First Name 名字",
                      textController: firstNameText,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "ᠨᠡᠷ᠎ᠡ ᠬᠡᠷᠡᠭᠲᠡᠢ First Name is required 需要名字";
                        }
                      },
                    ),
                    inputFile(
                      label: "ᠤᠪᠤᠭ Last Name 姓氏",
                      textController: lastNameText,
                    ),
                    // inputFile(label: "Phone Number", textController: phoneText),
                  ],
                ),
                Container(
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
                    height: 60,
                    onPressed: () => _signUp(context),
                    color: Colors.green[700],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "ᡴᡭᡬᢞᡬᡭᡪᢊᡪᢋᡭ Sign up 注册",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    Text(
                      "  Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var username = usernameText.text;
    var email = emailText.text;
    var password = passwordText.text;
    var firstName = firstNameText.text;
    var lastName = lastNameText.text;
    RegisterResult result = await apiService.register(
        username, password, email, firstName, lastName);

    var snackbarText;

    if (result.success) {
      Navigator.of(context).pushReplacementNamed('/login');
      snackbarText = "Signup successful";
    } else {
      String errorMessage = result.errorMessage ?? "Unknown error";
      snackbarText = "Failed to sign up: " + errorMessage;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackbarText),
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
  Widget inputFile(
      {label,
      textController,
      obscureText = false,
      FormFieldValidator<String>? validator}) {
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
        TextFormField(
          obscureText: obscureText,
          validator: validator,
          controller: textController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFBDBDBD),
                ),
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
