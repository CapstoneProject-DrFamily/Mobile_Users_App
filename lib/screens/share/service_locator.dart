import 'package:drFamily_app/view_model/doctor_detail_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/symptom_page_view_model.dart';
import 'package:drFamily_app/view_model/landing_page_vm/landing_page_view_model.dart';
import 'package:drFamily_app/view_model/landing_view_model.dart';
import 'package:drFamily_app/view_model/search_page_viewmodel.dart';
import 'package:drFamily_app/view_model/sign_in_vm/sign_in_view_model.dart';
import 'package:drFamily_app/view_model/sign_in_vm/verify_otp_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  //Register models
  locator.registerFactory<LandingViewModel>(() => LandingViewModel());
  locator.registerFactory<SearchPageViewModel>(() => SearchPageViewModel());
  locator.registerFactory<DoctorDetailViewModel>(() => DoctorDetailViewModel());
  locator.registerFactory<SignInViewModel>(() => SignInViewModel());
  locator.registerFactory<VerifyOTPViewModel>(() => VerifyOTPViewModel());
  locator.registerFactory<LandingPageViewModel>(() => LandingPageViewModel());
  locator.registerFactory<SymptomePageViewModel>(() => SymptomePageViewModel());
}
