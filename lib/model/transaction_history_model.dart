class TransactionHistoryModel {
  final String serviceName,
      location,
      transactionID,
      doctorName,
      dateTimeStart,
      conclusion;
  final int status;
  final double servicePrice;
  String specialtyName, note;
  int specialtyId, serviceId, doctorId;
  List<String> diagnose;

  TransactionHistoryModel(
      {this.dateTimeStart,
      this.doctorName,
      this.location,
      this.serviceName,
      this.servicePrice,
      this.status,
      this.transactionID,
      this.conclusion,
      this.specialtyId,
      this.specialtyName,
      this.note,
      this.doctorId,
      this.serviceId});

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      transactionID: json['id'] as String,
      dateTimeStart: json['dateStart'] as String,
      status: json['status'] as int,
      servicePrice: json['servicePrice'] as double,
      doctorName: json['doctorName'] as String,
      serviceName: json['serviceName'] as String,
      location: json['location'] as String,
      conclusion: json['conclusion'] as String,
      specialtyId: json['specialtyId'] as int,
      specialtyName: json['specialtyName'] as String,
      note: json['note'] as String,
      serviceId: json['serviceId'] as int,
      doctorId: json['doctorId'] as int,
    );
  }
}
