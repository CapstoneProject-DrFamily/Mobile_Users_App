class HealthRecordModel {
  int healthRecordID, patientID, disable;
  double birthWeight, birthHeight;
  String insBy, insDatetime;
  String conditionAtBirth, birthDefects, otherDefects;
  String medicineAllergy, chemicalAllergy, foodAllergy, otherAllergy;
  String disease, cancer, tuberculosis, otherDiseases;
  String hearing, eyesight, hand, leg, scoliosis, cleftLip, otherDisabilities;
  String surgeryHistory;
  String medicineAllergyFamily,
      chemicalAllergyFamily,
      foodAllergyFamily,
      otherAllergyFamily;
  String diseaseFamily, cancerFamily, tuberculosisFamily, otherDiseasesFamily;
  String other;
  String smokingFrequency,
      drinkingFrequency,
      drugFrequency,
      activityFrequency,
      exposureElement,
      contactTime,
      toiletType,
      otherRisks;

  HealthRecordModel(
      {this.healthRecordID,
      this.conditionAtBirth,
      this.birthWeight,
      this.birthHeight,
      this.birthDefects,
      this.otherDefects,
      this.medicineAllergy,
      this.chemicalAllergy,
      this.foodAllergy,
      this.otherAllergy,
      this.disease,
      this.cancer,
      this.tuberculosis,
      this.otherDiseases,
      this.hearing,
      this.eyesight,
      this.hand,
      this.leg,
      this.scoliosis,
      this.cleftLip,
      this.otherDisabilities,
      this.surgeryHistory,
      this.medicineAllergyFamily,
      this.chemicalAllergyFamily,
      this.foodAllergyFamily,
      this.otherAllergyFamily,
      this.diseaseFamily,
      this.cancerFamily,
      this.tuberculosisFamily,
      this.otherDiseasesFamily,
      this.other,
      this.smokingFrequency,
      this.drinkingFrequency,
      this.drugFrequency,
      this.activityFrequency,
      this.exposureElement,
      this.contactTime,
      this.toiletType,
      this.otherRisks,
      this.patientID,
      this.disable,
      this.insBy,
      this.insDatetime});

  factory HealthRecordModel.fromJson(Map<String, dynamic> json) {
    return HealthRecordModel(
      healthRecordID: json['id'] as int,
      conditionAtBirth: json['conditionAtBirth'] as String,
      birthWeight: json['birthWeight'] as double,
      birthHeight: json['birthHeight'] as double,
      birthDefects: json['birthDefects'] as String,
      otherDefects: json['otherDefects'] as String,
      medicineAllergy: json['medicineAllergy'] as String,
      chemicalAllergy: json['chemicalAllergy'] as String,
      foodAllergy: json['foodAllergy'] as String,
      otherAllergy: json['otherAllergy'] as String,
      disease: json['disease'] as String,
      cancer: json['cancer'] as String,
      tuberculosis: json['tuberculosis'] as String,
      otherDiseases: json['otherDiseases'] as String,
      hearing: json['hearing'] as String,
      eyesight: json['eyesight'] as String,
      hand: json['hand'] as String,
      leg: json['leg'] as String,
      scoliosis: json['scoliosis'] as String,
      cleftLip: json['cleftLip'] as String,
      otherDisabilities: json['otherDisabilities'] as String,
      surgeryHistory: json['surgeryHistory'] as String,
      medicineAllergyFamily: json['medicineAllergyFamily'] as String,
      chemicalAllergyFamily: json['chemicalAllergyFamily'] as String,
      foodAllergyFamily: json['foodAllergyFamily'] as String,
      otherAllergyFamily: json['otherAllergyFamily'] as String,
      diseaseFamily: json['diseaseFamily'] as String,
      cancerFamily: json['cancerFamily'] as String,
      tuberculosisFamily: json['tuberculosisFamily'] as String,
      otherDiseasesFamily: json['otherDiseasesFamily'] as String,
      other: json['other'] as String,
      smokingFrequency: json['smokingFrequency'] as String,
      drinkingFrequency: json['drinkingFrequency'] as String,
      drugFrequency: json['drugFrequency'] as String,
      activityFrequency: json['activityFrequency'] as String,
      exposureElement: json['exposureElement'] as String,
      contactTime: json['contactTime'] as String,
      toiletType: json['toiletType'] as String,
      otherRisks: json['otherRisks'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "conditionAtBirth": this.conditionAtBirth,
        "birthWeight": this.birthWeight,
        "birthHeight": this.birthHeight,
        "birthDefects": this.birthDefects,
        "otherDefects": this.otherDefects,
        "medicineAllergy": this.medicineAllergy,
        "chemicalAllergy": this.chemicalAllergy,
        "foodAllergy": this.foodAllergy,
        "otherAllergy": this.otherAllergy,
        "disease": this.disease,
        "cancer": this.cancer,
        "tuberculosis": this.tuberculosis,
        "otherDiseases": this.otherDiseases,
        "hearing": this.hearing,
        "eyesight": this.eyesight,
        "hand": this.hand,
        "conditihandonAtBirth": this.conditionAtBirth,
        "leg": this.leg,
        "scoliosis": this.scoliosis,
        "cleftLip": this.cleftLip,
        "otherDisabilities": this.otherDisabilities,
        "surgeryHistory": this.surgeryHistory,
        "medicineAllergyFamily": this.medicineAllergyFamily,
        "chemicalAllergyFamily": this.chemicalAllergyFamily,
        "foodAllergyFamily": this.foodAllergyFamily,
        "otherAllergyFamily": this.otherAllergyFamily,
        "diseaseFamily": this.diseaseFamily,
        "cancerFamily": this.cancerFamily,
        "tuberculosisFamily": this.tuberculosisFamily,
        "otherDiseasesFamily": this.otherDiseasesFamily,
        "other": this.other,
        "smokingFrequency": this.smokingFrequency,
        "drinkingFrequency": this.drinkingFrequency,
        "drugFrequency": this.drugFrequency,
        "activityFrequency": this.activityFrequency,
        "exposureElement": this.exposureElement,
        "contactTime": this.contactTime,
        "toiletType": this.toiletType,
        "otherRisks": this.otherRisks,
        "patientId": this.patientID,
        "disable": this.disable,
        "insBy": this.insBy,
        "insDatetime": insDatetime,
      };
}
