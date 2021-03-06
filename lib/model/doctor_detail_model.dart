class DoctorDetailModel {
  final String doctorDegree,
      doctorExperience,
      doctorDescription,
      doctorSpecialty,
      doctorName,
      doctorImage,
      doctorSchool,
      tokenNoti;
  final int doctorId, transactionBooked, feedbackCount;
  final double ratingPoint;
  DoctorDetailModel(
      {this.doctorImage,
      this.doctorDegree,
      this.doctorDescription,
      this.doctorExperience,
      this.doctorId,
      this.doctorName,
      this.doctorSchool,
      this.doctorSpecialty,
      this.ratingPoint,
      this.transactionBooked,
      this.tokenNoti,
      this.feedbackCount});

  factory DoctorDetailModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailModel(
      doctorId: json['id'] as int,
      doctorDegree: json['degree'] as String,
      doctorExperience: json['experience'] as String,
      doctorDescription: json['description'] as String,
      doctorSpecialty: json['specialty']['name'] as String,
      doctorName: json['fullname'] as String,
      doctorSchool: json['school'] as String,
      doctorImage: json['image'] as String,
      ratingPoint: json['ratingPoint'] as double,
      transactionBooked: json['bookedCount'] as int,
      feedbackCount: json['feedbackCount'] as int,
      tokenNoti: json['idNavigation']['notiToken'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "doctorId": this.doctorId,
        "doctorDegree": this.doctorDegree,
        "doctorExperience": this.doctorExperience,
        "doctorDescription": this.doctorDescription,
        "doctorSpecialty": this.doctorSpecialty,
        "doctorName": this.doctorName,
        "doctorSchool": this.doctorSchool,
        "doctorImage": this.doctorImage,
      };
}
