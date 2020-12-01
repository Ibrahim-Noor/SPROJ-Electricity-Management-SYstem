import 'package:flutter/material.dart';
import 'package:web_socket/homeScreen.dart';
import 'Globals.dart' as G;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:web_socket/socketio.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  Map<dynamic, dynamic> dataa;
  bool messageSent = false;
  String error;
  String userID;
  bool _loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   G.socketUtil.socket.on("loginConfirmation", (data) {
  //     if (data == "confirmed") {
  //     } else {
  //       this.setState(() {
  //         this.error = data;
  //       });
  //     }
  //   });
  // }

  // _asyncMethod() async {

  // }

  Future<String> _logUserIn(email, password) async {
    // handles user login

    try {
      var result = await http.post('http://10.0.2.2:3000/users',
          body: {'username': email, 'password': password});

      var response = json.decode(result.body);
      // print(response);
      if (response['error'] == false && response['id'] != Null) {
        String message = response['id'].toString();
        SharedPreferences prefs = await SharedPreferences
            .getInstance(); // store the user's information locally
        this.userID = message;
        prefs.setString("userid", message); // session id
        prefs.setString("email", email);
        prefs.setString("password", password);
        return 'ok';
      } else {
        return 'Invalid login credentials';
      }
    } catch (error) {
      print(error);
      return 'error';
    }
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
    });

    final form = formKey.currentState;

    if (form.validate()) {
      var result =
          await _logUserIn(emailController.text, passwordController.text);

      if (result == 'ok') {
        G.socketUtil = SocketUtil(this.userID);
        await G.socketUtil.initSocket();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (_) => false,
        );
      } else if (result == 'error') {
        error = "Unable to reach paani server";
      } else {
        error = "Incorrect email or password";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Electricity Management System",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (text) {
                            if (text.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          controller: emailController,
                          // cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: 'Email address',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          validator: (text) {
                            if (text.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          // cursorColor: Theme.of(context).primaryColor,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.vpn_key),
                              suffixIcon: IconButton(
                                  icon: _obscurePassword
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  })),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: _loading ? null : _submit),
                ),
              ],
            )));
  }
}
