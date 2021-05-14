import 'package:drFamily_app/model/checkout_model.dart';
import 'package:drFamily_app/model/convert_curr_model.dart';
import 'package:drFamily_app/repository/checkout_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class CheckOutViewModel extends BaseModel {
  ICheckOutRepo _checkOutRepo = CheckOutRepo();
  CheckoutModel _checkoutModel;
  ConvertCurrModel _convertCurrModel;
  String _date, _service, _patientName, _phone;
  double _price;
  double _priceUSD;
  double _currency;

  String get date => _date;
  String get service => _service;
  String get patientName => _patientName;
  String get phone => _phone;
  double get price => _price;
  double get priceUSD => _priceUSD;
  double get currency => _currency;

  bool init = true;
  bool _isLoading;
  bool get isLoading => _isLoading;

  getCheckoutInfo(String transactionId) async {
    _isLoading = true;
    if (init) {
      _checkoutModel = await _checkOutRepo.getCheckOutInfo(transactionId);
      _convertCurrModel = await _checkOutRepo.getCurrency();
      print('ok2');
      _date = _checkoutModel.date;
      _service = _checkoutModel.service;
      _patientName = _checkoutModel.name;
      // _phone = _checkoutModel.phone;
      _price = _checkoutModel.price;
      _currency = _convertCurrModel.currency;
      _priceUSD = double.parse(
          (_price / _convertCurrModel.currency).toStringAsFixed(2));
      this.init = false;
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }
}
