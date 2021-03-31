class ConvertCurrModel {
  final double currency;

  ConvertCurrModel({this.currency});

  factory ConvertCurrModel.fromJson(Map<String, dynamic> json) {
    return ConvertCurrModel(currency: json['rates']['VND'] as double);
  }
}
