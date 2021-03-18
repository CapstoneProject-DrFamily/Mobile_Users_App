class HealthRecordModel {
  final int healthRecordID;
  final String insBy, insDatetime;

  HealthRecordModel({this.healthRecordID, this.insBy, this.insDatetime});

  Map<String, dynamic> toJson() =>
      {"recordId": healthRecordID, "insBy": insBy, "insDatetime": insDatetime};
}
