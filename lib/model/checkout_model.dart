class CheckoutModel {
  final String date, service, name, phone;
  final double price;

  CheckoutModel({this.date, this.service, this.name, this.phone, this.price});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
        date: json['dateStart'] as String,
        service: json['service']['serviceName'] as String,
        name: json['patient']['patientNavigation']['fullName'] as String,
        phone: json['patient']['patientNavigation']['phone'] as String,
        price: json['service']['servicePrice'] as double);
  }

  // Map<String, dynamic> toJson() => {
  //       "name": name,
  //       "price": price,
  //     };
}
