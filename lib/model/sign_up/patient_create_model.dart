class PatientCreateModel {
  final int profileId, healthRecordId, accountId;
  final String relationship;

  PatientCreateModel(
      {this.profileId, this.healthRecordId, this.relationship, this.accountId});

  Map<String, dynamic> toJson() => {
        "profileId": profileId,
        "recordId": healthRecordId,
        "relationship": relationship,
        "accountId": accountId
      };
}
