// import 'dart:convert';
// import 'package:flutter/material.dart';
//
//
// class ScanPage extends StatefulWidget {
//   @override
//   _ScanPageState createState() => _ScanPageState();
// }
//
// class _ScanPageState extends State<ScanPage> {
//   String qrCodeResult;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Scan using:" + (backCamera ? "Front Cam" : "Back Cam")),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(MaterialCommunityIcons.qrcode_scan),
//               onPressed: () async {
//                 ScanResult codeSanner = await BarcodeScanner.scan(
//                   options: ScanOptions(
//                     useCamera: -1,
//                   ),
//                 );
//                 setState(() {
//                   qrCodeResult = codeSanner.rawContent;
//                   userModel = UserModel.fromMap(jsonDecode(qrCodeResult));
//                   print(userModel.doseDate);
//                 });
//               },
//             )
//           ],
//         ),
//         body: userModel == null
//             ? Center(child: Text("Scan QR Code"))
//             : Container(
//           margin: EdgeInsets.symmetric(horizontal: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Result",
//                   style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text("User Name: ${userModel.name}"),
//               SizedBox(
//                 height: 12,
//               ),
//               Text("User Email: ${userModel.email}"),
//               SizedBox(
//                 height: 12,
//               ),
//               Text("Vaccine Type: ${userModel.vaccineType}"),
//               SizedBox(
//                 height: 12,
//               ),
//               Text("Dose Date: ${userModel.doseDate}"),
//             ],
//           ),
//         ));
//   }
// }
