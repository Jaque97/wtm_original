// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_bar_code_flutter/widgets/input_field.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:screenshot/screenshot.dart';
//
// import 'controllers/auth_controller.dart';
// import 'models/user_model.dart';
//
// class GeneratePage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => GeneratePageState();
// }
//
// class GeneratePageState extends State<GeneratePage> {
//   bool loading = false;
//   String dummyData;
//   TextEditingController nameCon = TextEditingController();
//   TextEditingController emailCon = TextEditingController();
//   TextEditingController passwordCon = TextEditingController();
//   TextEditingController vaccineCon = TextEditingController();
//   TextEditingController doseDateCon = TextEditingController();
//   AuthController authController = Get.put(AuthController());
//   DateTime startDate = DateTime.now();
//   ScreenshotController screenshotController = ScreenshotController();
//   UserModel userModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Generate QR code'),
//       ),
//       body: ModalProgressHUD(
//         inAsyncCall: loading,
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 12),
//           child: dummyData == null
//               ? SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: 12,
//                       ),
//                       InputField(
//                         hint: "Name",
//                         controller: nameCon,
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       InputField(
//                         hint: "Email",
//                         controller: emailCon,
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       InputField(
//                         hint: "Password",
//                         controller: passwordCon,
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       InputField(
//                         hint: "Vaccine Type",
//                         controller: vaccineCon,
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       DateTimeField(
//                         format: DateFormat("d-MMM-y"),
//                         maxLines: 1,
//                         controller: doseDateCon,
//                         decoration: InputDecoration(
//                             labelText: "Pick Start Date",
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black))),
//                         style: TextStyle(color: Colors.black),
//                         onShowPicker: (context, currentValue) async {
//                           startDate = await showDatePicker(
//                               context: context,
//                               firstDate: DateTime(1900),
//                               initialDate: currentValue ?? DateTime.now(),
//                               lastDate: DateTime(2100));
//                           if (startDate != null) {
//                             doseDateCon.text =
//                                 DateFormat("d-MMM-y").format(startDate);
//                           }
//                           return;
//                         },
//                       ),
//                       SizedBox(
//                         height: 12,
//                       ),
//                       InkWell(
//                         onTap: () => registerUser(),
//                         child: Container(
//                           width: Get.width,
//                           height: 60,
//                           color: Theme.of(context).primaryColor,
//                           child: Center(child: Text("Save")),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : Column(
//                   children: [
//                     Screenshot(
//                       controller: screenshotController,
//                       child: Container(
//                         padding: EdgeInsets.all(20),
//                         color: Colors.white,
//                         child: QrImage(
//                           data: dummyData,
//                           gapless: true,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     InkWell(
//                       onTap: () => saveQr(),
//                       child: Container(
//                         width: Get.width,
//                         height: 60,
//                         color: Theme.of(context).primaryColor,
//                         child: Center(child: Text("Save QR Code")),
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
//
//   registerUser() async {
//     setState(() {
//       loading = true;
//     });
//     userModel = UserModel(
//         email: emailCon.text,
//         name: nameCon.text,
//         doseDate: DateFormat("E d-MMM-y").format(startDate),
//         password: passwordCon.text,
//         vaccineType: vaccineCon.text,
//         userId: DateTime.now().millisecondsSinceEpoch.toString());
//     var result = await authController.signUp(userModel, passwordCon.text);
//     setState(() {
//       loading = false;
//     });
//     if (result == true) dummyData = json.encode(userModel.toMap());
//   }
//
//   saveQr() async {
//     // final directory =
//     //     (await getExternalStorageDirectory()).path; //from path_provide package
//     // String fileName = DateTime.now().microsecondsSinceEpoch.toString();
//     // var path = '$directory';
//     // print(path);
//     // screenshotController.captureAndSave(path, fileName: "abc.jpg");
//     // return;
//     screenshotController.capture().then((value) async {
//       try {
//         bool isGranted = await Permission.storage.request().isGranted;
//         ;
//         if (isGranted) {
//           _saveToGallery(value);
//         } else {
//           // Ask Permission
//           PermissionStatus status = await Permission.storage.request();
//           switch (status) {
//             case PermissionStatus.granted:
//               _saveToGallery(value);
//               break;
//             case PermissionStatus.denied:
//               debugPrint("Storage permission required to Save Image");
//               break;
//             case PermissionStatus.permanentlyDenied:
//             case PermissionStatus.restricted:
//               debugPrint(
//                   "Storage permission required to Save Image, allow permissions in Settings");
//               break;
//           }
//         }
//       } catch (exp) {
//         debugPrint("Storage Permission Error ${exp.toString()}");
//       }
//     });
//   }
//
//   Future<void> _saveToGallery(Uint8List imageFile) async {
//     try {
//       final result = await ImageGallerySaver.saveImage(imageFile,
//           name: userModel.name +
//               DateTime.now().millisecondsSinceEpoch.toString());
//       print(result);
//       Get.snackbar("Image Saved", "Check your gallery");
//     } on Exception catch (exp) {
//       debugPrint("Image Exception ${exp.toString()}");
//     }
//   }
// }
