class CheckoutModel {
  final String date, service, name;
  final double price;

  CheckoutModel({this.date, this.service, this.name, this.price});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
        date: json['dateStart'] as String,
        service: json['service']['name'] as String,
        name: json['patient']['fullname'] as String,
        // phone: json['patient']['phone'] as String,
        price: json['service']['price'] as double);
  }

  // Map<String, dynamic> toJson() => {
  //       "name": name,
  //       "price": price,
  //     };
}
