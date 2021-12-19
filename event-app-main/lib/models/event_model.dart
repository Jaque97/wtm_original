import 'dart:convert';
import 'dart:typed_data';

import 'package:event_app/models/user_model.dart';

class EventModel {
  String id;
  String title;
  String description;
  String image;
  dynamic startDate;
  dynamic endDate;
  dynamic startTime;
  bool isPaid;
  String price;
  String location;
  String joinedBy;
  Uint8List qrImage;
  UserModel joinedUser;

  EventModel(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.startDate,
      this.endDate,
      this.startTime,
      this.isPaid,
      this.price,
      this.location,
      this.joinedBy,
      this.qrImage,
      this.joinedUser});

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return new EventModel(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        image: map['image'] as String,
        startDate: map['startDate'],
        endDate: map['endDate'],
        startTime: map['startTime'],
        isPaid: map['isPaid'] as bool,
        price: map['price'] ?? "Free",
        location: map['location'] as String,
        joinedBy: map['joinedBy'] as String,
        qrImage: map['qrImage'] == null
            ? null
            : Uint8List.fromList(List.castFrom(json.decode(map['qrImage']))),
        joinedUser: map['joinedUser'] == null
            ? null
            : UserModel.fromMap(json.decode(map['joinedUser'])));
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'image': this.image,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'startTime': this.startTime,
      'isPaid': this.isPaid,
      'price': this.price,
      'location': this.location,
      'joinedBy': this.joinedBy,
      'qrImage': this.qrImage == null ? null : json.encode(this.qrImage),
      'joinedUser':
          this.joinedUser == null ? null : json.encode(this.joinedUser?.toMap())
    } as Map<String, dynamic>;
  }
}
