import 'package:event_app/app/locator.dart';
import 'package:event_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class UserHomeViewModel extends IndexTrackingViewModel {
  AuthService authService = locator<AuthService>();

  void logout() {
    authService.logout();
  }
}
