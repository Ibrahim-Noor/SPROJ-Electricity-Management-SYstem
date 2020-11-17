import 'package:flutter/material.dart';
import 'package:web_socket/homeScreen.dart';
import 'Globals.dart' as G;
import 'dart:convert';

class ChangeLimitScreen extends StatefulWidget {
  @override
  _ChangeLimitScreen createState() => _ChangeLimitScreen();
}

class _ChangeLimitScreen extends State<ChangeLimitScreen> {
  // Map<dynamic, dynamic> dataa;
  bool editSettings = false;
  bool settingsedited = false;
  final _formKey = GlobalKey<FormState>();
  // bool messageSent = false;
  TextEditingController usageController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // String error;
  // bool dataLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // G.socketUtil.socket.on("loginConfirmation", (data) {
    //   if (data == "confirmed") {
    //   } else {
    //     this.setState(() {
    //       this.error = data;
    //     });
    //   }
    // });
    usageController.text = G.userUsageLimit.toString();
  }

  // _asyncMethod() async {

  // }

  void changeUsageLimit() {
    final bool x = _formKey.currentState.validate();
    if (x) {
      G.userUsageLimit = double.parse(usageController.text);
      this.setState(() {
        this.editSettings = false;
        this.settingsedited = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context, settingsedited)},
          ),
          centerTitle: true,
          title: Text('Monthly Usage Limit'),
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
                      'Monthly Usage Limit',
                      style: TextStyle(fontSize: 20),
                    )),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          enabled: editSettings,
                          validator: (value) {
                            if (double.parse(value) < 0) {
                              return "Please Enter a valid value";
                            }
                            return null;
                          },
                          controller: usageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "'Usage Limit in kWs'",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 20),
                        child: FlatButton(
                            onPressed: () {
                              this.setState(() {
                                this.editSettings = true;
                              });
                            },
                            child: Text(
                              "Edit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('Update'),
                            onPressed: changeUsageLimit,
                          )),
                    ],
                  ),
                ),
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
