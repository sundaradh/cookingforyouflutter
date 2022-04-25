import 'dart:convert';

import 'package:cookingforyou/screens/signup.dart';
import 'package:cookingforyou/widgets/home.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String message = "";
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Image(
                      image: AssetImage("assets/on.png"),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _username,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.people,
                          color: Colors.yellow,
                        ),
                        hintText: 'username',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your username ";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String? username) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.red,
                        ),
                        hintText: 'Password',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please Enter a Password";
                        }
                        if (value.length < 8) {
                          return "Password Length must be more than 8";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: RaisedButton(
                      color: const Color(0xFFA23522),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      onPressed: () {
                        if (_fromKey.currentState!.validate()) {
                          login();
                          print("Sucessful");
                        } else {
                          print("Unsucessful");
                        }
                        Future.delayed(const Duration(seconds: 5), () {
                          //asynchronous delay
                          if (this.mounted) {
                            //checks if widget is still active and not disposed
                            setState(() {
                              //tells the widget builder to rebuild again because ui has updated
                              message =
                                  ""; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
                            });
                          }
                        });
                      },
                      child: Text("Login"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      borderSide: BorderSide(color: Colors.black),
                      child: Text("Sign Up"),
                    ),
                  ),
                  //
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future login() async {
    var apiurl =
        "https://cookingforyou.pythonanywhere.com/api/v1/dj-rest-auth/login/?format=json";
    Map mapdata = {
      'username': _username.text,
      'password': _password.text,
    };
    print("JSON DATA: $mapdata");
    http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);

    if (response.body.isNotEmpty) {
      var data = jsonDecode(response.body);
      print("DATA:$data");
      data = data.toString();
      data = data.substring(1, 4);
      if (data == 'key') {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("username", _username.text);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        setState(() {
          message = "Invalid username or password";
        });
      }
    }
  }
}
