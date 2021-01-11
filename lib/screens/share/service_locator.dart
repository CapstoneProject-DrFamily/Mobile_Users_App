import 'package:drFamily_app/screens/doctor_detail_page.dart';
import 'package:drFamily_app/view_model/doctor_detail_view_model.dart';
import 'package:drFamily_app/view_model/landing_view_model.dart';
import 'package:drFamily_app/view_model/search_page_viewmodel.dart';
import 'package:drFamily_app/view_model/sign_up_vm/sign_up_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  //Register models
  locator.registerFactory<LandingViewModel>(() => LandingViewModel());
  locator.registerFactory<SearchPageViewModel>(() => SearchPageViewModel());
  locator.registerFactory<DoctorDetailViewModel>(() => DoctorDetailViewModel());
  locator.registerFactory<SignUpViewModel>(() => SignUpViewModel());
}
