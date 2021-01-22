import 'package:drFamily_app/Helper/fire_base_link.dart';
import 'package:drFamily_app/model/specialty_model.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class SpecialtyScreenViewModel extends BaseModel {
  List<SpecialtyModel> _listSpecialty = [];
  bool _isLoading = false;

  //getters
  List<SpecialtyModel> get listSpecialty => _listSpecialty;
  bool get isLoading => _isLoading;

  SpecialtyScreenViewModel() {
    getListSpecialty();
  }

  Future<void> getListSpecialty() async {
    this._isLoading = true;
    notifyListeners();

    SpecialtyModel specialty1 = new SpecialtyModel(
        image: ImagesLinks.INTERNAL_MEDICINE_SPECIALTY,
        title: 'Internal medicine');
    _listSpecialty.add(specialty1);

    SpecialtyModel specialty2 = new SpecialtyModel(
        image: ImagesLinks.ENDOCRINOLOGY_SPECIALTY, title: 'Endocrinology');
    _listSpecialty.add(specialty2);

    SpecialtyModel specialty3 = new SpecialtyModel(
        image: ImagesLinks.CARDIOLOGY_SPECIALTY, title: 'Cardiology');
    _listSpecialty.add(specialty3);

    SpecialtyModel specialty4 = new SpecialtyModel(
        image: ImagesLinks.OPHTHALMOLOGY_SPECIALTY, title: 'Ophthalmology');
    _listSpecialty.add(specialty4);

    SpecialtyModel specialty5 = new SpecialtyModel(
        image: ImagesLinks.PEDIATRICS_SPECIALTY, title: 'Pediatrics');
    _listSpecialty.add(specialty5);

    await Future.delayed(
      Duration(seconds: 1),
    );
    this._isLoading = false;
    notifyListeners();
  }
}
