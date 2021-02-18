class HealthRecordModel {
  final String insBy, insDatetime;

  HealthRecordModel({this.insBy, this.insDatetime});

  Map<String, dynamic> toJson() => {"insBy": insBy, "insDatetime": insDatetime};
}
