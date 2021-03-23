class MedicineModel {
  String form, strength, name, activeIngredient;
  int medicineId;

  MedicineModel({
    this.form,
    this.strength,
    this.name,
    this.medicineId,
    this.activeIngredient,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      form: json['form'] as String,
      strength: json['strength'] as String,
      name: json['name'] as String,
      medicineId: json['medicineId'] as int,
      activeIngredient: json['activeIngredient'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "form": this.form,
        "strength": this.strength,
        "name": this.name,
        "medicineId": this.medicineId,
        "activeIngredient": this.activeIngredient,
      };
}
