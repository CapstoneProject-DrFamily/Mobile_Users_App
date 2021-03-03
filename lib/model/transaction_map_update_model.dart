class TransactionMapUpdateModel {
  final String transactionId, estimatedTime, location, note;
  final int doctorId, patientId, prescriptionId, status, examId;

  TransactionMapUpdateModel({
    this.doctorId,
    this.estimatedTime,
    this.examId,
    this.location,
    this.note,
    this.patientId,
    this.prescriptionId,
    this.status,
    this.transactionId,
  });

  Map<String, dynamic> toJson() => {
        "transactionId": this.transactionId,
        "doctorId": this.doctorId,
        "patientId": this.patientId,
        "prescriptionId": this.prescriptionId,
        "estimatedTime": this.estimatedTime,
        "status": this.status,
        "location": this.location,
        "note": this.note,
        "examId": this.examId,
      };
}
