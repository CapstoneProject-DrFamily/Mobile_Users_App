class DoctorInformationModel {
  final String doctorDegree,
      doctorExperience,
      doctorDescription,
      insBy,
      updBy,
      doctorSchool;
  final int doctorId, doctorSpecialty;

  DoctorInformationModel({
    this.doctorDegree,
    this.doctorDescription,
    this.doctorExperience,
    this.doctorId,
    this.insBy,
    this.updBy,
    this.doctorSchool,
    this.doctorSpecialty,
  });

  factory DoctorInformationModel.fromJson(Map<String, dynamic> json) {
    return DoctorInformationModel(
        doctorId: json['doctorId'] as int,
        doctorDegree: json['degree'] as String,
        doctorExperience: json['experience'] as String,
        doctorDescription: json['description'] as String,
        doctorSpecialty: json['specialtyId'] as int,
        doctorSchool: json['school'] as String,
        insBy: json['insBy'] as String,
        updBy: json['updBy'] as String);
  }

  Map<String, dynamic> toJson() => {
        "doctorId": this.doctorId,
        "doctorDegree": this.doctorDegree,
        "doctorExperience": this.doctorExperience,
        "doctorDescription": this.doctorDescription,
        "doctorSpecialty": this.doctorSpecialty,
        "insBy": this.insBy,
        "doctorSchool": this.doctorSchool,
        "updBy": this.updBy,
      };
}
