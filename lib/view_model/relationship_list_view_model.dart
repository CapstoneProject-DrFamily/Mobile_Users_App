import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/model/relationship.dart';

class RelationshipListViewModel extends BaseModel {
  List<String> _relationshipList = [
    'Father',
    'Mother',
    'Grandmother',
    'Grandfather',
    'Sister',
    'Brother'
  ];

  List<String> get relationshipList => _relationshipList;

  String _selectedValue;
  String get selectedValue => _selectedValue;

  bool _checked = false;
  bool get checked => _checked;

  void changeSelected(String newValue) {
    _selectedValue = newValue;
    notifyListeners();
  }
}
