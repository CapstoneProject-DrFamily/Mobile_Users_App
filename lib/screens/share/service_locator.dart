import 'package:drFamily_app/screens/home/find_doctor/list_doctor_page.dart';
import 'package:drFamily_app/view_model/doctor_detail_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/map_page_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/specialty_screen_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/symptom_page_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/time_line_examine_view_model.dart';
import 'package:drFamily_app/view_model/landing_page_vm/landing_page_view_model.dart';
import 'package:drFamily_app/view_model/landing_view_model.dart';
import 'package:drFamily_app/view_model/prescription_view_model.dart';
import 'package:drFamily_app/view_model/progress_page_view_model.dart';
import 'package:drFamily_app/view_model/relationship_list_view_model.dart';
import 'package:drFamily_app/view_model/search_page_viewmodel.dart';
import 'package:drFamily_app/view_model/sign_in_vm/sign_in_view_model.dart';
import 'package:drFamily_app/view_model/sign_in_vm/verify_otp_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  //Register models
  locator.registerFactory<LandingViewModel>(() => LandingViewModel());
  locator.registerFactory<ListDoctorPageViewModel>(
      () => ListDoctorPageViewModel());
  locator.registerFactory<DoctorDetailViewModel>(() => DoctorDetailViewModel());
  locator.registerFactory<SignInViewModel>(() => SignInViewModel());
  locator.registerFactory<VerifyOTPViewModel>(() => VerifyOTPViewModel());
  locator.registerFactory<LandingPageViewModel>(() => LandingPageViewModel());
  locator.registerFactory<SymptomePageViewModel>(() => SymptomePageViewModel());
  locator.registerFactory<ProgressPageViewModel>(() => ProgressPageViewModel());
  locator.registerFactory<TimeLineExamineViewModel>(
      () => TimeLineExamineViewModel());
  locator.registerFactory<MapPageViewModel>(() => MapPageViewModel());
  locator.registerFactory<RelationshipListViewModel>(
      () => RelationshipListViewModel());
  locator.registerFactory<PrescriptionViewModel>(() => PrescriptionViewModel());
  locator.registerFactory<SpecialtyScreenViewModel>(
      () => SpecialtyScreenViewModel());
}
