import 'dart:convert';
import 'package:web_socket/changeUsageLImit.dart';
import 'package:web_socket/roomUsageData.dart';

import 'Globals.dart' as G;

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PowerUsage {
  final double powerUsage;
  final String date;
  final charts.Color barColor = charts.ColorUtil.fromDartColor(Colors.blue);

  PowerUsage({@required this.powerUsage, @required this.date});
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool dataLoading = true;
  List<List> dataPowerUsage = [
    [200.0, "21/11/2019"],
    [300.0, "22/11/2019"],
    [210.0, "23/11/2019"],
    [201.0, "24/11/2019"],
    [500.0, "25/11/2019"]
  ];
  List<PowerUsage> powerUsages;
  var currentElectricityUsage = 0.0;
  var electricityUsed = 0.0;
  var usageLimit = G.userUsageLimit;
  bool buttonPressed = false;
  Map<String, double> unitsInfo;
  Map<String, double> billInfo;
  List<Color> colorList;
  // Map<String, dynamic> usage;

  _HomeScreen() {
    unitsInfo = {
      'Units Used (KW)': electricityUsed,
      'Units Remaining (KW)': usageLimit - electricityUsed
    };
    billInfo = {
      'Current Bill (Rs)': estimatedBill(electricityUsed),
      'Remaining Bill (Rs)':
          estimatedBill(usageLimit) - estimatedBill(electricityUsed)
    };
    colorList = [
      Colors.red,
      Colors.grey,
    ];
    print(dataPowerUsage
        .map((tuple) => PowerUsage(powerUsage: tuple[0], date: tuple[1])));
    powerUsages = dataPowerUsage
        .map((tuple) => PowerUsage(powerUsage: tuple[0], date: tuple[1]))
        .toList();
  }

  double estimatedBill(var unitsUsed) {
    return unitsUsed * 18.90;
  }

  double percentage(double currentValue, double maxValue) {
    return ((currentValue / maxValue) * 100);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getPowerData();
    G.socketUtil.sendMessage("house_number", [1]);
    getData();
  }

  Future<void> getData() async {
    G.socketUtil.socket.on("message", (data) {
      // data = json.encode(data);
      // print(data["AC_DR_kW"].runtimeType);
      // print(this.currentElectricityUsage.runtimeType);
      // print(data);
      // print("data");
      // print("dasdsa");
      // print(this.dataLoading);
      this.setState(() {
        // print(this.dataa);
        // this.usage = data;
        G.globalMap = data;
        this.currentElectricityUsage = double.parse(G.globalMap["Usage_kW"]);
        this.electricityUsed += this.currentElectricityUsage;
        this.dataLoading = false;
        // print(":ads");
        // print(this.currentElectricityUsage);
      });
    });
    // this.setState(() {

    // });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<PowerUsage, String>> series = [
      charts.Series(
        id: "Subscribers",
        data: powerUsages,
        domainFn: (PowerUsage series, _) => series.date,
        measureFn: (PowerUsage series, _) => series.powerUsage,
      )
    ];
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      appBar: AppBar(
        // actions: [
        //   RaisedButton(

        // ],
        // Here we take flutter cleanthe value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "Electricity Management System",
          style: TextStyle(fontSize: 19),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(145, 200, 255, 1),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () async {
                  var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeLimitScreen()));
                  if (result) {
                    this.setState(() {
                      this.usageLimit = G.userUsageLimit;
                    });
                  }
                },
                child: Icon(
                  Icons.settings,
                  size: 25,
                ),
              ))
        ],
      ),
      body: this.dataLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(0),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RoomUsageData()),
                    ),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 5,
                            blurRadius: 10),
                      ],
                    ),
                    margin: const EdgeInsets.only(top: 15.0),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Usage: ' +
                          this.currentElectricityUsage.toString() +
                          " KWH",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, spreadRadius: 5, blurRadius: 10),
                    ],
                  ),
                  margin: const EdgeInsets.only(top: 5.0),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => {
                        this.setState(() {
                          this.buttonPressed = !this.buttonPressed;
                        }),
                      },
                      child: SfRadialGauge(axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0,
                            maximum: buttonPressed
                                ? estimatedBill(this.usageLimit)
                                : this.usageLimit,
                            // showLabels: false,
                            showTicks: false,
                            axisLineStyle: AxisLineStyle(
                              thickness: 0.1,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Color.fromARGB(30, 0, 169, 181),
                              thicknessUnit: GaugeSizeUnit.factor,
                            ),
                            pointers: <GaugePointer>[
                              RangePointer(
                                  value: this.buttonPressed
                                      ? estimatedBill(this.electricityUsed)
                                      : this.electricityUsed,
                                  width: 0.1,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  cornerStyle: CornerStyle.startCurve,
                                  gradient: const SweepGradient(colors: <Color>[
                                    Color(0xFF00a9b5),
                                    Color(0xFFa4edeb)
                                  ], stops: <double>[
                                    0.25,
                                    0.75
                                  ])),
                              MarkerPointer(
                                  value: this.buttonPressed
                                      ? estimatedBill(this.electricityUsed)
                                      : this.electricityUsed,
                                  markerType: MarkerType.circle,
                                  color: const Color(0xFF87e8e8),
                                  markerHeight: 30,
                                  markerWidth: 30)
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  positionFactor: 0.1,
                                  angle: 90,
                                  widget: Text(
                                    this.buttonPressed
                                        ? 'Bill(Rs)\n' +
                                            percentage(
                                                    estimatedBill(
                                                        this.electricityUsed),
                                                    estimatedBill(
                                                        this.usageLimit))
                                                .toStringAsFixed(0) +
                                            "%"
                                        : 'Units(KWH)\n' +
                                            percentage(this.electricityUsed,
                                                    this.usageLimit)
                                                .toStringAsFixed(0) +
                                            "%",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ))
                            ])
                      ]),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  padding: EdgeInsets.all(20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Power data of the last 5 days',
                            style: Theme.of(context).textTheme.body2,
                          ),
                          Expanded(
                            child: charts.BarChart(series, animate: true),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
