class DoctorDetailModel {
  final String doctorDegree,
      doctorExperience,
      doctorDescription,
      doctorSpecialty,
      doctorName,
      doctorImage,
      doctorSchool;
  final int doctorId, transactionBooked;
  final double ratingPoint;
  DoctorDetailModel({
    this.doctorImage,
    this.doctorDegree,
    this.doctorDescription,
    this.doctorExperience,
    this.doctorId,
    this.doctorName,
    this.doctorSchool,
    this.doctorSpecialty,
    this.ratingPoint,
    this.transactionBooked,
  });

  factory DoctorDetailModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailModel(
      doctorId: json['doctorId'] as int,
      doctorDegree: json['degree'] as String,
      doctorExperience: json['experience'] as String,
      doctorDescription: json['description'] as String,
      doctorSpecialty: json['specialty']['name'] as String,
      doctorName: json['doctorNavigation']['fullName'] as String,
      doctorSchool: json['school'] as String,
      doctorImage: json['doctorNavigation']['image'] as String,
      ratingPoint: json['ratingPoint'] as double,
      transactionBooked: json['totalDoneTransaction'] as int,
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
