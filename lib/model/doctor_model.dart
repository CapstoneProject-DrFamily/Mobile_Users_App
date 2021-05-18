class DoctorModel {
  int id, year, service, feedback, booked;
  String name, speciality, image, notitoken, fbId;
  double latitude, longitude, distance, ratingPoint;
  bool isOnline;

  DoctorModel(
      {this.id,
      this.name,
      this.speciality,
      this.year,
      this.image,
      this.latitude,
      this.longitude,
      this.distance,
      this.notitoken,
      this.fbId,
      this.booked,
      this.feedback,
      this.ratingPoint,
      this.service});

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['doctorId'] as int,
      name: json['doctorName'] as String,
      speciality: json['doctorSpecialty'] as String,
      image: json['doctorImage'] as String,
      service: json['doctorServiceId'] as int,
      ratingPoint: json['ratingPoint'] as double,
      booked: json['bookedCount'] as int,
      feedback: json['feedbackCount'] as int,
    );
  }
}
