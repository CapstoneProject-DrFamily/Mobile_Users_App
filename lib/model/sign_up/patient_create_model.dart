class PatientCreateModel {
  final int patientId;
  final double height, weight;
  final String relationship, bloodType;

  PatientCreateModel(
      {this.patientId,
      this.relationship,
      this.height,
      this.bloodType,
      this.weight});

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "height": height,
        "weight": weight,
        "bloodType": bloodType,
        "relationship": relationship
      };
}
