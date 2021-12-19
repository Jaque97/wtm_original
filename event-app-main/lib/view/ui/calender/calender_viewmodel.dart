import 'package:event_app/app/locator.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/services/common_ui_service.dart';
import 'package:event_app/view/ui/event/event_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class CalenderViewModel extends BaseViewModel with CommonUiService {
  DateTime selectedDate = DateTime.now();
  List<EventModel> eventOnDate = [];
  EventViewModel eventViewModel = locator<EventViewModel>();

  onDateChange(DateTime date) {
    selectedDate = date;
    initialise();
    notifyListeners();
  }

  initialise() {
    if (StaticInfo.userModel.userType == "Admin") {
      eventOnDate = eventViewModel.allEvents
          .where((element) =>
              element.startDate.toDate().difference(selectedDate).inDays == 0)
          .toList();
    } else {
      eventOnDate = eventViewModel.upcomingFiltered
          .where((element) =>
              element.startDate.toDate().difference(selectedDate).inDays == 0)
          .toList();
    }
    notifyListeners();
  }
}
