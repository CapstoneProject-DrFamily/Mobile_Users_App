class ScheduleModel {
  int doctorId, scheduleId;
  String appointmentTime, insBy, updBy, updDatetime;
  bool status;

  ScheduleModel(
      {this.scheduleId,
      this.doctorId,
      this.appointmentTime,
      this.insBy,
      this.status,
      this.updBy,
      this.updDatetime});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'] as int,
      doctorId: json['doctorId'] as int,
      appointmentTime: json['appointmentTime'] as String,
      insBy: json['insBy'] as String,
      status: json['status'] as bool,
      updBy: json['updBy'] as String,
      updDatetime: json['updDatetime'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "scheduleId": this.scheduleId,
        "doctorId": this.doctorId,
        "appointmentTime": this.appointmentTime,
        "insBy": this.insBy,
        "status": this.status,
        "updBy": this.updBy,
        "updDatetime": this.updDatetime,
      };
}
