class DoctorDetailModel {
  final String doctorDegree,
      doctorExperience,
      doctorDescription,
      doctorSpecialty,
      doctorName,
      doctorImage,
      doctorSchool;
  final int doctorId;

  DoctorDetailModel({
    this.doctorImage,
    this.doctorDegree,
    this.doctorDescription,
    this.doctorExperience,
    this.doctorId,
    this.doctorName,
    this.doctorSchool,
    this.doctorSpecialty,
  });

  factory DoctorDetailModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailModel(
      doctorId: json['doctorId'] as int,
      doctorDegree: json['degree'] as String,
      doctorExperience: json['experience'] as String,
      doctorDescription: json['description'] as String,
      doctorSpecialty: json['specialty']['name'] as String,
      doctorName: json['profile']['fullName'] as String,
      doctorSchool: json['school'] as String,
      doctorImage: json['profile']['image'] as String,
    );
  }
}
