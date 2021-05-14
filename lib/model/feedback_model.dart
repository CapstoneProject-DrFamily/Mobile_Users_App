class FeedbackModel {
  String feedbackId;
  double ratingPoint;
  // int patientId, doctorId;
  String note, insBy, updBy;
  String insDatetime;

  FeedbackModel(
      {this.feedbackId,
      this.ratingPoint,
      // this.patientId,
      // this.doctorId,
      this.note,
      this.insBy,
      this.updBy,
      this.insDatetime});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      feedbackId: json['id'] as String,
      ratingPoint: json['ratingPoint'] as double,
      // patientId: json['patientId'] as int,
      // doctorId: json['doctorId'] as int,
      note: json['note'] as String,
      insBy: json['insBy'] as String,
      updBy: json['updBy'] as String,
      insDatetime: json['insDatetime'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": this.feedbackId,
        "ratingPoint": this.ratingPoint,
        // "patientId": this.patientId,
        // "doctorId": this.doctorId,
        "note": this.note,
        "insBy": this.insBy,
        "updBy": this.updBy
      };
}
