import 'package:drFamily_app/view_model/checkout_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/doctor_detail_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/old_doctor_vm/old_doctor_screen_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/reason_booking_real_time_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/specialty_service_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/symptom_screen_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:drFamily_app/view_model/landing_page_vm/history_record/history_record_screen_view_model.dart';
import 'package:drFamily_app/view_model/map_choose_profile_screen_view_model.dart';
import 'package:drFamily_app/view_model/payment_vm/payment_view_model.dart';
import 'package:drFamily_app/view_model/rating_vm/rating_base_view_model.dart';
import 'package:drFamily_app/view_model/schedule_vm/appointment_view_model.dart';
import 'package:drFamily_app/view_model/schedule_vm/doctor_detail_schedule_view_model.dart';
import 'package:drFamily_app/view_model/schedule_vm/list_doctor_schedule_view_model.dart';
import 'package:drFamily_app/view_model/schedule_vm/list_schedule_appointment_view_model.dart';
import 'package:drFamily_app/view_model/schedule_vm/reason_appointment_view_model.dart';
import 'package:drFamily_app/view_model/setting_vm/dependent_health_record_view_model.dart';
import 'package:drFamily_app/view_model/setting_vm/dependent_profile_view_model.dart';
import 'package:drFamily_app/view_model/setting_vm/dependent_view_model.dart';
import 'package:drFamily_app/view_model/setting_vm/health_record_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/map_page_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/specialty_screen_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/symptom_page_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/time_line_examine_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/waiting_booking_doctor_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/home_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/pop_up_choose_patient_view_model.dart';
import 'package:drFamily_app/view_model/landing_page_vm/landing_page_view_model.dart';
import 'package:drFamily_app/view_model/landing_page_vm/setting_view_model.dart';
import 'package:drFamily_app/view_model/prescription_view_model.dart';
import 'package:drFamily_app/view_model/progress_page_view_model.dart';
import 'package:drFamily_app/view_model/setting_vm/add_dependent_profile_screen_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/list_doctor_screen_view_model.dart';
import 'package:drFamily_app/view_model/setting_vm/old_health_record_view_model.dart';
import 'package:drFamily_app/view_model/setting_vm/policy_view_model.dart';
import 'package:drFamily_app/view_model/setting_vm/profile_screen_view_model.dart';
import 'package:drFamily_app/view_model/sign_in_vm/sign_in_view_model.dart';
import 'package:drFamily_app/view_model/sign_in_vm/verify_otp_view_model.dart';
import 'package:drFamily_app/view_model/signup_view_model.dart';
import 'package:drFamily_app/view_model/transaction_vm/awaiting_sample_view_model.dart';
import 'package:drFamily_app/view_model/transaction_vm/transaction_base_view_model.dart';
import 'package:drFamily_app/view_model/transaction_vm/transaction_detail_view_model.dart';
import 'package:drFamily_app/view_model/transaction_vm/transaction_form_view_model.dart';
import 'package:drFamily_app/view_model/transaction_vm/transaction_prescription_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  //Register models
  locator.registerFactory<ListDoctorScreenViewModel>(
      () => ListDoctorScreenViewModel());
  locator.registerFactory<DoctorDetailViewModel>(() => DoctorDetailViewModel());
  locator.registerFactory<SignInViewModel>(() => SignInViewModel());
  locator.registerFactory<VerifyOTPViewModel>(() => VerifyOTPViewModel());
  locator.registerFactory<LandingPageViewModel>(() => LandingPageViewModel());
  locator.registerFactory<SymptomePageViewModel>(() => SymptomePageViewModel());
  locator.registerFactory<ProgressPageViewModel>(() => ProgressPageViewModel());
  locator.registerFactory<TimeLineExamineViewModel>(
      () => TimeLineExamineViewModel());
  locator.registerFactory<MapPageViewModel>(() => MapPageViewModel());
  locator.registerFactory<AddDependentProfileScreenViewModel>(
      () => AddDependentProfileScreenViewModel());
  locator.registerFactory<PrescriptionViewModel>(() => PrescriptionViewModel());
  locator.registerFactory<SpecialtyScreenViewModel>(
      () => SpecialtyScreenViewModel());
  locator
      .registerFactory<ProfileScreenViewModel>(() => ProfileScreenViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<PopUpChoosePatientViewModel>(
      () => PopUpChoosePatientViewModel());
  locator.registerFactory<HealthRecordViewModel>(() => HealthRecordViewModel());
  locator.registerFactory<SettingViewModel>(() => SettingViewModel());
  locator.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  locator.registerFactory<WaitingBookingDoctorViewModel>(
      () => WaitingBookingDoctorViewModel());
  locator.registerFactory<DependentViewModel>(() => DependentViewModel());
  locator.registerFactory<DependentProfileViewModel>(
      () => DependentProfileViewModel());
  locator.registerFactory<DependentHealthRecordViewModel>(
      () => DependentHealthRecordViewModel());
  locator.registerFactory<HistoryRecordScreenViewModel>(
      () => HistoryRecordScreenViewModel());
  locator.registerFactory<RatingBaseViewModel>(() => RatingBaseViewModel());
  locator.registerFactory<TransactionDetailViewModel>(
      () => TransactionDetailViewModel());
  locator.registerFactory<TransactionBaseViewModel>(
      () => TransactionBaseViewModel());
  locator.registerFactory<TransactionFormViewModel>(
      () => TransactionFormViewModel());
  locator.registerFactory<TransactionPrescriptionViewModel>(
      () => TransactionPrescriptionViewModel());
  locator.registerFactory<CheckOutViewModel>(() => CheckOutViewModel());
  locator.registerFactory<PaymentViewModel>(() => PaymentViewModel());

  locator.registerFactory<ListDoctorScheduleViewModel>(
      () => ListDoctorScheduleViewModel());

  locator.registerFactory<AppointmentViewModel>(() => AppointmentViewModel());
  locator.registerFactory<ReasonAppointmentViewModel>(
      () => ReasonAppointmentViewModel());

  locator.registerFactory<DoctorDetailScheduleViewModel>(
      () => DoctorDetailScheduleViewModel());

  locator.registerFactory<ListScheduleAppointmentViewModel>(
      () => ListScheduleAppointmentViewModel());
  locator.registerFactory<BaseTimeLineViewModel>(() => BaseTimeLineViewModel());
  locator.registerFactory<SpecialtyServiceViewModel>(
      () => SpecialtyServiceViewModel());
  locator
      .registerFactory<SymptomScreenViewModel>(() => SymptomScreenViewModel());
  locator.registerFactory<BaseTimeLineAppoinmentViewModel>(
      () => BaseTimeLineAppoinmentViewModel());
  locator.registerFactory<ReasonBookingRealTimeViewModel>(
      () => ReasonBookingRealTimeViewModel());
  locator.registerFactory<MapChooseProfileViewModel>(
      () => MapChooseProfileViewModel());

  locator.registerFactory<OldDoctorScreenViewModel>(
      () => OldDoctorScreenViewModel());

  locator.registerFactory<PolicyViewModel>(() => PolicyViewModel());
  locator.registerFactory<AwaitingSampleViewModel>(
      () => AwaitingSampleViewModel());
  locator.registerFactory<OldHealthRecordViewModel>(
      () => OldHealthRecordViewModel());
}
