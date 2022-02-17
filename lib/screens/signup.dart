import 'dart:convert';

import 'package:cookingforyou/screens/login.dart';
import 'package:cookingforyou/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String message = "";
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _comfirmpassword = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Signup",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                    child: Image(
                      image: AssetImage("assets/on.png"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _name,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.green,
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
                          return "Please Enter Your Full Name ";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String? name) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.amberAccent,
                        ),
                        hintText: 'Email',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Email ";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Prease Enter Valid Email";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String? email) {},
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
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _comfirmpassword,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.red,
                        ),
                        hintText: 'Confirm Password',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please re-type your Password";
                        }
                        if (_comfirmpassword.text != _password.text) {
                          return "Password Doesnot Match";
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: RaisedButton(
                          color: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          onPressed: () {
                            if (_fromKey.currentState!.validate()) {
                              register();
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
                          child: Text("Sign up"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do you have already an account?"),
                      GestureDetector(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future register() async {
    var apiurl =
        "https://cookingforyou.pythonanywhere.com/api/v1/dj-rest-auth/registration/?format=json";
    Map mapdata = {
      'username': _name.text,
      'email': _email.text,
      'password1': _password.text,
      'password2': _password.text,
    };
    print("JSON DATA: $mapdata");
    http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);

    if (response.body.isNotEmpty) {
      var data = jsonDecode(response.body);
      data = data.toString();
      if (data.substring(1, 4) == 'key') {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("username", _name.text);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      }
      setState(() {
        message = data;
      });
    }
  }
}
