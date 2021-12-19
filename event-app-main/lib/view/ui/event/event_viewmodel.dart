import 'package:event_app/app/locator.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/services/common_ui_service.dart';
import 'package:event_app/services/event_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:event_app/app/locator.dart';
import 'package:event_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';



@singleton
class EventViewModel extends IndexTrackingViewModel with CommonUiService {
  EventService eventService = locator<EventService>();
  AuthService authService = locator<AuthService>();

  void logout(){
    authService.logout();
  }

  bool loading = true;
  List<EventModel> allEvents = [];
  List<EventModel> upcomingFiltered = [];
  List<EventModel> completedFiltered = [];

  bool isProcessing = false;

  setProcessing(bool val) {
    isProcessing = val;
    notifyListeners();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  initialise() async {
    setLoading(true);
    var response = await eventService.getAllEvents();
    if (response != false) {
      allEvents = response;
      updateLists();
    }
    print(upcomingFiltered.length);
    print(completedFiltered.length);
    setLoading(false);
  }

  deleteEvent(EventModel eventModel) async {
    setProcessing(true);
    var response = await eventService.deleteEvent(eventModel);
    setProcessing(false);
    if (response != false) {
      allEvents.remove(eventModel);
      updateLists();
      showSnackBar("Event Deleted");
    } else {
      showSnackBar("Please try again later");
    }
  }

  void updateLists() {
    upcomingFiltered = allEvents
        .where((element) => element.startDate.toDate().isAfter(DateTime.now()))
        .toList();

    completedFiltered = allEvents
        .where((element) => element.startDate.toDate().isBefore(DateTime.now()))
        .toList();
  }

  onFilter(String key) {
    if (currentIndex == 0) {
      if (key != "") {
        updateLists();
        upcomingFiltered = upcomingFiltered
            .where((element) => element.title.contains(key))
            .toList();
      } else {
        updateLists();
      }
    } else {
      if (key != "") {
        updateLists();
        completedFiltered = upcomingFiltered
            .where((element) => element.title.contains(key))
            .toList();
      } else {
        updateLists();
      }
    }
    notifyListeners();
  }
}
