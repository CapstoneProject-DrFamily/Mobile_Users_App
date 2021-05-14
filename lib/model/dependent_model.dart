class DependentModel {
  final String dependentName, dependentImage, dependentRelationShip;
  final int patientID, profileID;

  DependentModel(
      {this.dependentImage,
      this.dependentName,
      this.dependentRelationShip,
      this.patientID,
      this.profileID});

  factory DependentModel.fromJson(Map<String, dynamic> json) {
    return DependentModel(
        patientID: json['patientID'] as int,
        dependentImage: json['dependentImage'] as String,
        dependentName: json['dependentName'] as String,
        dependentRelationShip: json['dependentRelationShip'] as String,
        profileID: json['patientID'] as int);
  }
}
