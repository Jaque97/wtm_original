import 'package:event_app/view/ui/login/login_view.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  initialise() async {
    await Future.delayed(Duration(seconds: 2));
    Get.to(LoginView());
  }
}
