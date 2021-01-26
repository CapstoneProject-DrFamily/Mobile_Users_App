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
      note: "Sáng: 1 viên, Trưa: 2 viên, Chiều: 3 viên",
    ),
    Prescription(
      id: 2,
      name: "Simenic",
      unitPerDay: 2,
      unitPerTimes: 1,
      day: 3,
      note: "Sáng: 3 viên, Trưa: 2 viên, Chiều: 1 viên",
    ),
    Prescription(
      id: 3,
      name: "Livetin",
      unitPerDay: 3,
      unitPerTimes: 3,
      day: 3,
      note: "Sáng: 2 viên, Trưa: 2 viên, Chiều: 2 viên",
    ),
    Prescription(
      id: 4,
      name: "Paracetamol",
      unitPerDay: 2,
      unitPerTimes: 3,
      day: 2,
      note: "Sáng: 1 viên, Trưa: 1 viên, Chiều: 1 viên",
    ),
    // Prescription(
    //   id: 5,
    //   name: "Efpharan",
    //   unitPerDay: 2,
    //   unitPerTimes: 3,
    //   day: 2,
    //   note: "Sáng: 1 viên, Trưa: 2 viên, Chiều: 2 viên",
    // ),
  ];
}
