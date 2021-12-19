import 'package:event_app/app/locator.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/services/auth_service.dart';
import 'package:event_app/services/common_ui_service.dart';
import 'package:event_app/view/ui/admin_home/admin_home_view.dart';
import 'package:event_app/view/ui/user_home/user_home_view.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  AuthService authService = locator<AuthService>();
  CommonUiService commonUiService = locator<CommonUiService>();
  bool loading = false;

  bool isRemember = true;

  setIsRemember(bool val) {
    isRemember = val;
    notifyListeners();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      commonUiService.showSnackBar("Please fill all the fields");
      return;
    } else if (!GetUtils.isEmail(email)) {
      commonUiService.showSnackBar("Invalid Email");
      return;
    }
    setLoading(true);
    var result = await authService.login(email, password);
    setLoading(false);
    print(result);
    if (result == "success") {
      if (StaticInfo.userModel.userType == "admin") {
        Get.offAll(() => AdminHomeView());
      } else {
        Get.offAll(() => UserHomeView());
      }
    } else {
      if (result == AuthStatus.ERROR_INVALID_EMAIL) {
        commonUiService.showSnackBar("Email address is invalid");
      } else if (result == AuthStatus.ERROR_WRONG_PASSWORD) {
        commonUiService.showSnackBar("Wrong password");
      } else if (result == AuthStatus.ERROR_USER_NOT_FOUND) {
        commonUiService.showSnackBar("User not found");
      } else {
        commonUiService.showSnackBar(result);
      }
    }
  }
}
