class AdditionInfoModel {
  String bloodType, relationship;
  double height, weight;
  int patientId, profileId, recordId, accountId;

  AdditionInfoModel(
      {this.patientId,
      this.bloodType,
      this.height,
      this.weight,
      this.profileId,
      this.recordId,
      this.relationship,
      this.accountId});

  factory AdditionInfoModel.fromJson(Map<String, dynamic> json) {
    return AdditionInfoModel(
      patientId: json['patientId'] as int,
      bloodType: json['bloodType'] as String,
      height: json['height'] as double,
      weight: json['weight'] as double,
      profileId: json['profileId'] as int,
      recordId: json['recordId'] as int,
      relationship: json['relationship'] as String,
      accountId: json['accountId'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "height": height,
        "weight": weight,
        "bloodType": bloodType,
        "profileId": profileId,
        "recordId": recordId,
        "relationship": relationship,
        "accountId": accountId,
      };
}
