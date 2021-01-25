import 'package:drFamily_app/model/prescription.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class PrescriptionViewModel extends BaseModel {
  Prescription prescription = new Prescription();
  List<Prescription> list = [
    Prescription(
      id: 1,
      name: "Sucrafil",
      unitPerDay: 3,
      unitPerTimes: 2,
      day: 3,
      note: "",
    ),
    Prescription(
      id: 2,
      name: "Simenic",
      unitPerDay: 2,
      unitPerTimes: 1,
      day: 3,
      note: "",
    ),
    Prescription(
      id: 3,
      name: "Livetin",
      unitPerDay: 3,
      unitPerTimes: 3,
      day: 3,
      note: "",
    ),
  ];
}
