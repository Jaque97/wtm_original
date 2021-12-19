import 'package:event_app/app/locator.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/services/auth_service.dart';
import 'package:event_app/services/common_ui_service.dart';
import 'package:event_app/view/ui/admin_home/admin_home_view.dart';
import 'package:event_app/view/ui/user_home/user_home_view.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  AuthService authService = locator<AuthService>();
  CommonUiService commonUiService = locator<CommonUiService>();
  bool loading = false;

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  signUpUser(String name, String email, String phone, String password) async {
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      commonUiService.showSnackBar("Please fill all the details");
      return;
    } else if (password.length < 6) {
      commonUiService.showSnackBar("Password should be at least 6 character");
      return;
    }

    UserModel user =
        UserModel(userType: "user", name: name, phone: phone, email: email);
    setLoading(true);
    var result = await authService.signUp(user, password);
    setLoading(false);
    if (result == "success") {
      if (StaticInfo.userModel.userType == "admin") {
        Get.offAll(() => AdminHomeView());
      } else {
        Get.offAll(() => UserHomeView());
      }
    } else {
      if (result == AuthStatus.ERROR_INVALID_EMAIL) {
        commonUiService.showSnackBar("Email address is invalid");
      } else if (result == AuthStatus.ERROR_WEAK_PASSWORD) {
        commonUiService
            .showSnackBar("Password should be at least 6 characters");
      } else if (result == AuthStatus.ERROR_EMAIL_ALREADY_IN_USE) {
        commonUiService.showSnackBar("Email already in use");
      } else {
        commonUiService.showSnackBar(result);
      }
    }
  }
}
