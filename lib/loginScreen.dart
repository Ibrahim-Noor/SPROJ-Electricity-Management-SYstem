import 'package:flutter/material.dart';
import 'package:web_socket/homeScreen.dart';
import 'Globals.dart' as G;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  Map<dynamic, dynamic> dataa;
  bool messageSent = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error;
  bool dataLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    G.socketUtil.socket.on("loginConfirmation", (data) {
      if (data == "confirmed") {
      } else {
        this.setState(() {
          this.error = data;
        });
      }
    });
  }

  // _asyncMethod() async {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
        ),
        body: this.dataLoading
            ? CircularProgressIndicator()
            : Padding(
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
                    error != null
                        ? Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              error,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.red,
                              ),
                            ))
                        : Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                          ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    // FlatButton(
                    //   onPressed: () {
                    //     //forgot password screen
                    //   },
                    //   textColor: Colors.blue,
                    //   child: Text('Forgot Password'),
                    // ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Login'),
                          onPressed: () {
                            print(nameController.text);
                            print(passwordController.text);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (_) => false,
                            );
                            // this.messageSent = true;
                            // G.socketUtil.sendMessage("login",
                            //     [nameController.text, passwordController.text]);
                          },
                        )),
                    // Container(
                    //     child: Row(
                    //   children: <Widget>[
                    //     Text('Does not have account?'),
                    //     FlatButton(
                    //       textColor: Colors.blue,
                    //       child: Text(
                    //         'Sign in',
                    //         style: TextStyle(fontSize: 20),
                    //       ),
                    //       onPressed: () {
                    //         //signup screen
                    //       },
                    //     )
                    //   ],
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    // ))
                  ],
                )));
  }
}
