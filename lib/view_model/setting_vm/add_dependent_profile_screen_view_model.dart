import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/cupertino.dart';

class AddDependentProfileScreenViewModel extends BaseModel {
  // controller
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  TextEditingController _relationshipController = TextEditingController();
  TextEditingController get relationshipController => _relationshipController;
  //listrealtion
  List<String> _relationshipList = [
    'Father',
    'Mother',
    'Grandmother',
    'Grandfather',
    'Sister',
    'Brother',
    'Child',
  ];
  List<String> get relationshipList => _relationshipList;
  //string value text field
  String _relationshipValue;
  String get relationshipValue => _relationshipValue;
  String _fullNameValue;
  String get fullNameValue => _fullNameValue;
  String _phoneNumValue;
  String get phoneNumValue => _phoneNumValue;
  //Constructor
  AddDependentProfileScreenViewModel() {
    _fullNameController.addListener(() {
      _fullNameValue = _fullNameController.text;
      notifyListeners();
    });
    _phoneController.addListener(() {
      _phoneNumValue = _phoneController.text;
      notifyListeners();
    });
    _relationshipController.addListener(() {
      _relationshipValue = _relationshipController.text;
      notifyListeners();
    });
  }
  //function choose relationship
  void chooseRelationship(String newValue) {
    _relationshipController.text = newValue;
    notifyListeners();
  }

  void completeProcess() {
    print("Name: " +
        _fullNameValue +
        "Phone: " +
        _phoneNumValue +
        "Relation: " +
        _relationshipValue);
  }
}
