class PatientCreateModel {
  final int patientId;
  final double height, weight;
  final String relationship, bloodType, location;

  PatientCreateModel(
      {this.patientId,
      this.relationship,
      this.height,
      this.bloodType,
      this.weight,
      this.location});

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "height": height,
        "weight": weight,
        "bloodType": bloodType,
        "relationship": relationship,
        "location": location,
      };
}
