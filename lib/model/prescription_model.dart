import 'package:drFamily_app/model/medicine_model.dart';

class PrescriptionModel {
  String prescriptionId, method, type;
  int medicineId,
      morningQuantity,
      noonQuantity,
      afternoonQuantity,
      totalQuantity,
      totalDays;
  MedicineModel medicine;

  PrescriptionModel(
      {this.prescriptionId,
      this.method,
      this.type,
      this.medicineId,
      this.morningQuantity,
      this.noonQuantity,
      this.afternoonQuantity,
      this.totalQuantity,
      this.totalDays});

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      prescriptionId: json['prescriptionId'] as String,
      method: json['method'] as String,
      type: json['type'] as String,
      medicineId: json['medicineId'] as int,
      morningQuantity: json['morningQuantity'] as int,
      noonQuantity: json['noonQuantity'] as int,
      afternoonQuantity: json['afternoonQuantity'] as int,
      totalQuantity: json['totalQuantity'] as int,
      totalDays: json['totalDays'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "prescriptionId": this.prescriptionId,
        "method": this.method,
        "type": this.type,
        "medicineId": this.medicineId,
        "morningQuantity": this.morningQuantity,
        "noonQuantity": this.noonQuantity,
        "afternoonQuantity": this.afternoonQuantity,
        "totalQuantity": this.totalQuantity,
        "totalDays": this.totalDays,
      };
}
