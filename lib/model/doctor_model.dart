class DoctorModel {
  int id, year;
  String name, speciality, image, notitoken, fbId;
  double latitude, longitude, distance;

  double rating;
  String description, schoolStudy, degree;

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
      this.fbId});

  DoctorModel.fullInfo(
      {this.id,
      this.name,
      this.speciality,
      this.year,
      this.image,
      this.rating,
      this.description,
      this.degree,
      this.schoolStudy,
      this.latitude,
      this.longitude,
      this.distance});
}
