import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/model/feedback_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/repository/feedback_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';

class DoctorDetailScheduleViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();
  final IFeedbackRepo _feedbackRepo = FeedbackRepo();

  DoctorDetailModel _doctor;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool loadingFeedback = true;
  bool loadingMore = false;
  List<FeedbackModel> listFeedback;
  bool hasNextPage = true;
  int page = 1;

  Future<void> getDoctorDetail(int doctorId) async {
    _doctor = await _doctorRepo.getDoctor(doctorId);

    print("done");
  }

  Future<void> fetchFeedback(DoctorScheduleModel model) async {
    if (this.loadingFeedback) {
      print(model.doctorDetail.doctorId);
      List<dynamic> result = await _feedbackRepo.getListFeedback(
          model.doctorDetail.doctorId, this.page, 5);
      this.listFeedback = result[0];
      this.hasNextPage = result[1];
      print('has next page :' + this.hasNextPage.toString());

      this.loadingFeedback = false;
      notifyListeners();
    }
  }

  void nextStep(BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel,
      DoctorScheduleModel doctorScheduleModel) {
    baseTimeLineAppoinmentViewModel.doctorScheduleModel = doctorScheduleModel;

    baseTimeLineAppoinmentViewModel.nextStep();
  }

  Future<void> nextPage(DoctorScheduleModel model) async {
    this.loadingMore = true;
    notifyListeners();
    this.page = this.page + 1;
    print("page " + this.page.toString());
    List<dynamic> result = await _feedbackRepo.getListFeedback(
        model.doctorDetail.doctorId, this.page, 5);
    List<FeedbackModel> listTemp = result[0];
    this.hasNextPage = result[1];
    for (int i = 0; i < listTemp.length; i++) {
      this.listFeedback.add(listTemp[i]);
    }
    this.loadingMore = false;
    notifyListeners();
  }
}
