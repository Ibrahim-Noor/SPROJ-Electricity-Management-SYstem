// import 'dart:js';
import 'package:web_socket/homeScreen.dart';
import 'package:web_socket/roomUsageData.dart';

import 'Globals.dart' as G;
import 'package:flutter/material.dart';
import 'package:web_socket/socketio.dart';

import 'loginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  G.socketUtil = SocketUtil();
  await G.socketUtil.initSocket();
  print(G.socketUtil.socket);
  runApp(
    MaterialApp(initialRoute: '/', routes: {
      '/': (context) => LoginScreen(),
      '/mainScreen': (context) => HomeScreen(),
      '/roomUsageScreen': (context) => RoomUsageData(),
    }),
  );
}
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {

// }

// Container getButtonSet(String identifier) {
//   bool ipc = isProbablyConnected(identifier);
//   return Container(
//     height: 60.0,
//     child: ListView(
//       scrollDirection: Axis.horizontal,
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 8.0),
//           child: RaisedButton(
//             child: Text("Connect"),
//             onPressed: ipc ? null : () => initSocket(identifier),
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//           ),
//         ),
//         Container(
//             margin: EdgeInsets.symmetric(horizontal: 8.0),
//             child: RaisedButton(
//               child: Text("Send Message"),
//               onPressed: ipc ? () => sendMessage(identifier) : null,
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//             )),
//         Container(
//             margin: EdgeInsets.symmetric(horizontal: 8.0),
//             child: RaisedButton(
//               child: Text("Send w/ ACK"), //Send message with ACK
//               onPressed: ipc ? () => sendMessageWithACK(identifier) : null,
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//             )),
//         Container(
//             margin: EdgeInsets.symmetric(horizontal: 8.0),
//             child: RaisedButton(
//               child: Text("Disconnect"),
//               onPressed: ipc ? () => disconnect(identifier) : null,
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//             )),
//       ],
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           textTheme: TextTheme(
//             title: TextStyle(color: Colors.white),
//             headline: TextStyle(color: Colors.white),
//             subtitle: TextStyle(color: Colors.white),
//             subhead: TextStyle(color: Colors.white),
//             body1: TextStyle(color: Colors.white),
//             body2: TextStyle(color: Colors.white),
//             button: TextStyle(color: Colors.white),
//             caption: TextStyle(color: Colors.white),
//             overline: TextStyle(color: Colors.white),
//             display1: TextStyle(color: Colors.white),
//             display2: TextStyle(color: Colors.white),
//             display3: TextStyle(color: Colors.white),
//             display4: TextStyle(color: Colors.white),
//           ),
//           buttonTheme: ButtonThemeData(
//               padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
//               disabledColor: Colors.lightBlueAccent.withOpacity(0.5),
//               buttonColor: Colors.lightBlue,
//               splashColor: Colors.cyan)),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Adhara Socket.IO example'),
//           backgroundColor: Colors.black,
//           elevation: 0.0,
//         ),
//         body: Container(
//           color: Colors.black,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Expanded(
//                   child: Center(
//                 child: ListView(
//                   children: toPrint.map((String _) => Text(_ ?? "")).toList(),
//                 ),
//               )),
//               Padding(
//                 padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
//                 child: Text(
//                   "Default Connection",
//                 ),
//               ),
//               getButtonSet("default"),
//               Padding(
//                 padding: EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
//                 child: Text(
//                   "Alternate Connection",
//                 ),
//               ),
//               getButtonSet("alternate"),
//               Padding(
//                 padding: EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
//                 child: Text(
//                   "Namespace Connection",
//                 ),
//               ),
//               getButtonSet("namespaced"),
//               SizedBox(
//                 height: 12.0,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
