class DoctorModel {
  int id, year, service, feedback, booked;
  String name, speciality, image, notitoken, fbId;
  double latitude, longitude, distance, ratingPoint;

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
}
