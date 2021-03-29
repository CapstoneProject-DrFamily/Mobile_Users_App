import 'package:drFamily_app/model/checkout_model.dart';
import 'package:drFamily_app/repository/checkout_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class CheckOutViewModel extends BaseModel {
  ICheckOutRepo _checkOutRepo = CheckOutRepo();
  CheckoutModel _checkoutModel;
  String _date, _service, _patientName, _phone;
  double _price;

  String get date => _date;
  String get service => _service;
  String get patientName => _patientName;
  String get phone => _phone;
  double get price => _price;

  bool init = true;
  bool _isLoading;
  bool get isLoading => _isLoading;

  getCheckoutInfo(String transactionId) async {
    _isLoading = true;
    notifyListeners();
    if (init) {
      print('ok');
      _checkoutModel = await _checkOutRepo.getCheckOutInfo(transactionId);
      print('ok2');
      _date = _checkoutModel.date;
      _service = _checkoutModel.service;
      _patientName = _checkoutModel.name;
      _phone = _checkoutModel.phone;
      _price = _checkoutModel.price;
      this.init = false;
      notifyListeners();
    }
    _isLoading = false;
  }
}
