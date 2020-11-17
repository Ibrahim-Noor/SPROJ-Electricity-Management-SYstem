import 'package:flutter/material.dart';
import 'getRoomsWidget.dart';
import 'Globals.dart' as G;
import 'dart:async';

class RoomUsageData extends StatefulWidget {
  // final Map<String, dynamic> usage;
  // RoomUsageData({Key key, @required this.usage}) : super(key: key);
  @override
  _RoomUsageData createState() => _RoomUsageData();
}

class _RoomUsageData extends State<RoomUsageData> {
  // Map usage;
  // _RoomUsageData(this.usage);
  Map<String, dynamic> usage = G.globalMap;
  bool dataLoading1 = false;
  Timer _setUsage;
  // @override
  // BuildContext get context => super.context;

  // void didChangeDependencies(){
  // this.usage = Provider.
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // G.socketUtil.sendMessage('house_number', [1]);
    // getData();
    _setUsage = Timer.periodic(new Duration(seconds: 1), (timer) {
      this.setState(() {
        this.usage = G.globalMap;
      });
    });

    // timer = new Timer(new Duration(seconds: 1), () {
    //   this.setState(() {
    //     this.usage = G.globalMap;
    //   });
    //   ;
    // });
  }

  @override
  void dispose() {
    _setUsage?.cancel();
    super.dispose();
  }

  // Future<void> getData() async {
  //   G.socketUtil.socket.on("message", (data) {
  //     // data = json.encode(data);
  //     // print(data["AC_DR_kW"].runtimeType);
  //     // print(this.currentElectricityUsage.runtimeType);
  //     // print(data);
  //     // print("data");
  //     print(this.dataLoading1);
  //     this.setState(() {
  //       // print(this.dataa);
  //       // this.usage = G.globalMap;
  //       // print(":ads");
  //       if (this.dataLoading1) {
  //         this.dataLoading1 = false;
  //       }
  //       // print(this.currentElectricityUsage);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: new IconButton(
          //     icon: new Icon(Icons.arrow_back),
          //     onPressed: () {
          //       this.dataLoading1 = true;
          //       Navigator.pop(context, true);
          //     }),
          // Here we take flutter cleanthe value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            "Electricity Management System",
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(145, 200, 255, 1),
        ),
        body: ListView(children: roomsList(this.usage, context)));
  }

  // Future<bool> _onBackPressed(BuildContext context) {
  //   this.dataLoading1 = false;
  //   Navigator.pop(context) ?? false;
  // }
}
