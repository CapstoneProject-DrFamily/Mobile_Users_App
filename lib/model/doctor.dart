import 'package:firebase_database/firebase_database.dart';

class Doctor {
  int id, year;
  String name, speciality, image;
  double latitude, longitude, distance;

  double rating;
  String description, schoolStudy, degree;

  Doctor(
      {this.id,
      this.name,
      this.speciality,
      this.year,
      this.image,
      this.latitude,
      this.longitude,
      this.distance});

  Doctor.fullInfo(
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
