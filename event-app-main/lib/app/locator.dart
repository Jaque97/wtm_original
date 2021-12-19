import 'package:event_app/services/auth_service.dart';
import 'package:event_app/services/common_ui_service.dart';
import 'package:event_app/services/event_service.dart';
import 'package:event_app/services/image_service.dart';
import 'package:event_app/view/ui/calender/calender_viewmodel.dart';
import 'package:event_app/view/ui/event/event_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  locator.registerLazySingleton(() => CommonUiService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => EventService());
  locator.registerLazySingleton(() => ImageService());
  // locator.registerLazySingleton(() => PaymentServices());

  locator.registerSingleton<EventViewModel>(EventViewModel());
  locator.registerSingleton<CalenderViewModel>(CalenderViewModel());
}
