class TransactionMapModel {
  final String transactionId,
      doctorName,
      placeName,
      doctorImage,
      doctorSpecialty,
      doctorDegree,
      transactionNote,
      location,
      estimateTime;
  final double longitude, latitude;
  final int doctorId, patientId, examId;
  final List<SymptomTempModel> patientSymptom;

  TransactionMapModel(
      {this.doctorDegree,
      this.doctorImage,
      this.doctorName,
      this.doctorSpecialty,
      this.latitude,
      this.placeName,
      this.longitude,
      this.transactionNote,
      this.patientSymptom,
      this.doctorId,
      this.patientId,
      this.location,
      this.estimateTime,
      this.transactionId,
      this.examId});
}

class SymptomTempModel {
  final String symptomName, symptomtype;

  SymptomTempModel({this.symptomName, this.symptomtype});

  factory SymptomTempModel.fromJson(Map<String, dynamic> json) {
    return SymptomTempModel(
      symptomName: json['symptom']['name'] as String,
      symptomtype: json['symptom']['type'] as String,
    );
  }
}
