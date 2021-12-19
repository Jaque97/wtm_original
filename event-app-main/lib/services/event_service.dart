import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/app/locator.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/services/image_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EventService {
  String _eventKey = "events";
  ImageService imageService = locator<ImageService>();

  Future addEvent(EventModel eventModel) async {
    try {
      String url = await imageService.saveFiles(eventModel.image, "Images");
      if (url == null) return;
      eventModel.image = url;
      await FirebaseFirestore.instance
          .collection(_eventKey)
          .doc(eventModel.id)
          .set(eventModel.toMap(), SetOptions(merge: true));
      return eventModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getAllEvents() async {
    List<EventModel> allEvents = [];
    try {
      var result = await FirebaseFirestore.instance.collection(_eventKey).get();
      for (var doc in result.docs) {
        allEvents.add(EventModel.fromMap(doc.data()));
      }
      print(allEvents.length);
      return allEvents;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future deleteEvent(EventModel eventModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_eventKey)
          .doc(eventModel.id)
          .delete();
      return eventModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future joinEvent(EventModel eventModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("joinedEvent")
          .doc(eventModel.id)
          .set(eventModel.toMap(), SetOptions(merge: true));
      return eventModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getJoinedEvents() async {
    List<EventModel> allEvents = [];
    try {
      var result = await FirebaseFirestore.instance
          .collection("joinedEvent")
          .where("joinedBy", isEqualTo: StaticInfo.userModel.id)
          .get();
      print(result.docs.length);
      for (var doc in result.docs) {
        allEvents.add(EventModel.fromMap(doc.data()));
      }
      return allEvents;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
