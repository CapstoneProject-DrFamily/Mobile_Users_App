class HealthRecordModel {
  final int patientID, disable;
  final String insBy, insDatetime;

  HealthRecordModel(
      {this.patientID, this.insBy, this.insDatetime, this.disable});

  Map<String, dynamic> toJson() => {
        "patientId": patientID,
        "insBy": insBy,
        "insDatetime": insDatetime,
        "disable": disable
      };
}
