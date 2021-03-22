import 'package:drFamily_app/model/form_parameter_model.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class TransactionFormViewModel extends BaseModel {
  List<FormParameterModel> listParameter = [
    FormParameterModel(name: 'Cardiovascular', description: ""),
    FormParameterModel(name: 'Respiratory', description: ""),
    FormParameterModel(name: 'Gastroenterology', description: ""),
    FormParameterModel(name: 'Nephrology', description: ""),
    FormParameterModel(name: 'Rheumatology', description: ""),
    FormParameterModel(name: 'Endocrine', description: ""),
    FormParameterModel(name: 'Nerve', description: ""),
    FormParameterModel(name: 'Mental', description: ""),
    FormParameterModel(name: 'Surgery', description: ""),
    FormParameterModel(name: 'Obstetrics & Gynecology', description: ""),
    FormParameterModel(name: 'Otorhinolaryngology', description: ""),
    FormParameterModel(name: 'Odonto-Stomatology', description: ""),
    FormParameterModel(name: 'Ophthalmology', description: ""),
    FormParameterModel(name: 'Dermatology', description: ""),
    FormParameterModel(name: 'Nutrition', description: ""),
    FormParameterModel(name: 'Activity', description: ""),
    // Speciality(name: 'Khác', description: ""),
    FormParameterModel(name: 'Evaluation', description: ""),
  ];
}
