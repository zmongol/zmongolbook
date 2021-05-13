import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/network/api_service.dart';

class SignupPage extends StatelessWidget {
  final apiService = ApiService(Dio(), BASE_URL + ":8080");
  final usernameText = TextEditingController();
  final passwordText = TextEditingController();
  final confirmPasswordText = TextEditingController();
  final emailText = TextEditingController();
  final firstNameText = TextEditingController();
  final lastNameText = TextEditingController();
  // final phoneText = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's free ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: [
                  inputFile(label: "Username", textController: usernameText),
                  inputFile(
                      label: "Password",
                      obscureText: true,
                      textController: passwordText),
                  inputFile(
                      label: "Confirm Password",
                      obscureText: true,
                      textController: confirmPasswordText),
                  inputFile(label: "Email", textController: emailText),
                  inputFile(label: "First Name", textController: firstNameText),
                  inputFile(label: "Last Name", textController: lastNameText),
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
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up",
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
                    " Login",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    var username = usernameText.text;
    var email = emailText.text;
    var password = passwordText.text;
    var firstName = firstNameText.text;
    var lastName = lastNameText.text;
    String? errorMsg = await apiService.register(
        username, password, email, firstName, lastName);

    var snackbarText;
    if (errorMsg == null) {
      Navigator.of(context).pushReplacementNamed('/login');
      snackbarText = "Signup successful";
    } else {
      snackbarText = "Failed to sign up: " + errorMsg;
    }

     ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(snackbarText),),);
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
  Widget inputFile({label, textController, obscureText = false}) {
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
