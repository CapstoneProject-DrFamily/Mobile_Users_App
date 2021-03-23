import 'package:drFamily_app/Helper/helper_method.dart';
import 'package:drFamily_app/model/transaction_history_model.dart';
import 'package:drFamily_app/repository/setting/profile_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/home/find_doctor/time_line_examine_page.dart';
import 'package:drFamily_app/screens/landing_page/map_tracking_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/screens/transaction/transaction_base_screen.dart';
import 'package:drFamily_app/screens/transaction/transaction_detail_screen.dart';
import 'package:drFamily_app/view_model/landing_page_vm/map_tracking_screen_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRecordScreenViewModel extends BaseModel {
  final IProfileRepo profileRepo = ProfileRepo();
  final ITransactionRepo transactionRepo = TransactionRepo();

  String _fullUserName;
  String get fullUserName => _fullUserName;
  int _profileId;
  int _patientId;
  // TextEditingController _fullNameUser = TextEditingController();
  // TextEditingController get fullNameUser => _fullNameUser;

  List<TransactionHistoryModel> _listTransaction = [];
  List<TransactionHistoryModel> get listTransaction => _listTransaction;

  List _historyTime = ['All', 'On Going', 'Checking', 'Done', 'Cancel'];
  List get historyTime => _historyTime;

  int _status = 0;
  int get status => _status;

  bool _isFirst = true;
  bool get isFirst => _isFirst;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _loadingList = false;
  bool get loadingList => _loadingList;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  DatabaseReference _transactionRequest;

  Future<void> initHistory() async {
    if (_isFirst) {
      _isLoading = true;
      _transactionRequest =
          FirebaseDatabase.instance.reference().child("Transaction");

      _isNotHave = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userName = prefs.getString('usFullName');
      _fullUserName = userName;
      _profileId = prefs.getInt("usProfileID");

      _patientId = await profileRepo.getPatientId(_profileId.toString());

      _listTransaction = await transactionRepo.getListTransactionHistory(
          _patientId.toString(), -1);

      if (_listTransaction == null) {
        _isNotHave = true;
      }

      _isLoading = false;
      _isFirst = false;
      notifyListeners();
      // print("oke");
    }
  }

  void changePatients(
      BuildContext context, int profileId, String fullName) async {
    _status = 0;
    _isLoading = true;
    _isNotHave = false;
    Navigator.pop(context);
    notifyListeners();
    _fullUserName = fullName;
    _profileId = profileId;
    _patientId = await profileRepo.getPatientId(_profileId.toString());

    _listTransaction = await transactionRepo.getListTransactionHistory(
        _patientId.toString(), -1);

    if (_listTransaction == null) {
      _isNotHave = true;
    }

    _isLoading = false;
    _isFirst = false;
    notifyListeners();
  }

  void changeStatus(int status) async {
    switch (status) {
      case 0:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _patientId.toString(), -1);

          _loadingList = false;
          if (_listTransaction == null) {
            _isNotHave = true;
          }

          notifyListeners();
        }

        break;
      case 1:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _patientId.toString(), 1);
          _loadingList = false;
          if (_listTransaction == null) {
            _isNotHave = true;
          }
          notifyListeners();
        }

        break;
      case 2:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _patientId.toString(), 2);
          _loadingList = false;
          if (_listTransaction == null) {
            _isNotHave = true;
          }

          notifyListeners();
        }

        break;
      case 3:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _patientId.toString(), 3);
          _loadingList = false;

          if (_listTransaction == null) {
            _isNotHave = true;
          }

          notifyListeners();
        }

        break;
      case 4:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _patientId.toString(), 4);
          _loadingList = false;
          if (_listTransaction == null) {
            _isNotHave = true;
          }

          notifyListeners();
        }

        break;
      default:
    }
  }

  void chooseTransaction(
      BuildContext context, String transactionId, int transactionStatus) async {
    switch (transactionStatus) {
      case 1:
        {
          var doctorFbID;
          await _transactionRequest
              .child(transactionId)
              .once()
              .then((DataSnapshot dataSnapshot) {
            Map<dynamic, dynamic> values = dataSnapshot.value;
            if (values == null) {
              print("not have");
            } else {
              doctorFbID = values['doctor_FBId'];
            }
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapTrackingScreen(
                model: MapTrackingScreenViewModel(transactionId, doctorFbID),
              ),
            ),
          ).then((value) async {
            HelperMethod.disabltransactionStatusUpdate();
            HelperMethod.disableUpdateDoctorLocation();
            HelperMethod.disableTransactionMapUpdates();
            await initHistory();
          });
        }
        break;
      case 2:
        {
          TimeLineExamineScreen.transactionID = transactionId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimeLineExamineScreen(),
            ),
          ).then((value) async {
            await initHistory();
          });
        }
        break;
      case 3:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionBaseScreen(transactionId: transactionId),
            ),
          );
        }
        break;
      case 4:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionBaseScreen(transactionId: transactionId),
            ),
          );
        }
        break;
      default:
    }
  }
}
