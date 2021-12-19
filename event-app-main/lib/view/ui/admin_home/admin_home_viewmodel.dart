import 'package:event_app/app/locator.dart';
import 'package:event_app/services/auth_service.dart';
import 'package:event_app/services/common_ui_service.dart';
import 'package:event_app/view/ui/add_event/add_event_view.dart';
import 'package:event_app/view/ui/event/event_viewmodel.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class AdminHomeViewModel extends IndexTrackingViewModel with CommonUiService {
  Future<void> addEvent() async {
    var response = await Get.to(() => AddEventView());
    if (response != null) {
      locator<EventViewModel>().allEvents.add(response);
      locator<EventViewModel>().updateLists();
    }
  }

  void logout() {
    locator<AuthService>().logout();
  }
}
