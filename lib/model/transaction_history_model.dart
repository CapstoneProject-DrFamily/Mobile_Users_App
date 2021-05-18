class TransactionHistoryModel {
  final String serviceName, location, transactionID, doctorName, dateTimeStart;
  final int status;
  final double servicePrice;
  TransactionHistoryModel(
      {this.dateTimeStart,
      this.doctorName,
      this.location,
      this.serviceName,
      this.servicePrice,
      this.status,
      this.transactionID});

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      transactionID: json['id'] as String,
      dateTimeStart: json['dateStart'] as String,
      status: json['status'] as int,
      servicePrice: json['servicePrice'] as double,
      doctorName: json['doctorName'] as String,
      serviceName: json['serviceName'] as String,
      location: json['location'] as String,
    );
  }
}
