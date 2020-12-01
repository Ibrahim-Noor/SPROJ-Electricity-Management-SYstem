import 'package:flutter/material.dart';

String getRoomName(String shortName) {
  String result;
  if (shortName == "BR1") {
    result = 'Bedroom 1';
  } else if (shortName == "GR") {
    result = 'Game Room';
  } else if (shortName == "MB") {
    result = "Main Bedroom";
  } else if (shortName == "SR") {
    result = "Sun Room";
  } else if (shortName == "Dr") {
    result = "Dining Room";
  } else if (shortName == "BR3") {
    result = "Bedroom 3";
  } else if (shortName == "BR2") {
    result = "Bedroom 2";
  } else if (shortName == "Reg") {
    result = "Regular";
  } else if (shortName == "BR") {
    result = "Bedroom";
  } else if (shortName == "DNR") {
    result = "Dining Room";
  } else if (shortName == "DR") {
    result = "Drawing Room";
  } else if (shortName == "UPS") {
    result = "UPS";
  } else if (shortName == "MBR") {
    result = "Main Bedroom";
  } else if (shortName == "LR") {
    result = "Living Room";
  } else {
    result = shortName;
  }
  return result;
}

Widget listWidgets(BuildContext context, String name, String usage,
    {String component = ""}) {
  // return ListTile(title: Text(name),  ,)
  return Container(
    margin: EdgeInsets.fromLTRB(0, 0, 0, 7.0),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(196, 196, 196, 0.7),
            offset: Offset(0, 1.0),
            spreadRadius: 3.0,
            blurRadius: 5.0)
      ],
      color: Color.fromRGBO(238, 239, 239, 0.8),
      // border:
      //     Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
    ),
    // alignment: AlignmentGeometry.lerp(),
    height: MediaQuery.of(context).size.height * 0.3,
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              )
            ],
          ),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Usage",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            component != ""
                ? Text(
                    component + ": " + usage + " kWs",
                    style: TextStyle(fontSize: 20.0),
                  )
                : Text(usage + "kWs"),
          ],
        ))
      ],
    ),
  );
}

List<Widget> roomsList(Map usage, BuildContext context) {
  final children = <Widget>[];
  print(usage.runtimeType);
  // print(usage);
  usage.forEach((key, value) {
    List a = key.split('_');
    if (a[0] == "Usage" || a[0] == "Date" || key == '_id') {
    } else if (a.length > 2) {
      children.add(listWidgets(
          context, getRoomName(a[1]), double.parse(value).toString(),
          component: a[0]));
    } else if (a.length == 2) {
      listWidgets(context, getRoomName(a[0]), double.parse(value).toString());
    }
  });
  return children;
  // for (var i = 0; i < listOfRoomsAbbreviation.length; i++) {
  //   listOfRooms.add(giveRoomName(listOfRoomsAbbreviation[i]));
  // }
  // usage.forEach((key, value) {
  //   if (key != "Date_Time" && key != "Usage_kW") {
  //     children.add(listWidgets(name, usage))
  //   }
  // })
}
