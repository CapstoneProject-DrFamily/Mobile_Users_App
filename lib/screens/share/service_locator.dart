import 'package:drFamily_app/view_model/landing_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  //Register models
  locator.registerFactory<LandingViewModel>(() => LandingViewModel());
}
