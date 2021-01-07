class Doctor {
  int id, year;
  String name, speciality, url;

  double rating;
  String description, schoolStudy, degree;

  Doctor({this.id, this.name, this.speciality, this.year, this.url});

  Doctor.fullInfo(
      {this.id,
      this.name,
      this.speciality,
      this.year,
      this.url,
      this.rating,
      this.description,
      this.degree,
      this.schoolStudy});
}
