import 'package:drFamily_app/model/setting/addition_info_model.dart';

class ProfileModel {
  int profileId, accountID;
  String fullName, dob, gender, phone, image, email, idCard;
  AdditionInfoModel additionInfoModel;

  ProfileModel(
      {this.profileId,
      this.fullName,
      this.dob,
      this.gender,
      this.phone,
      this.image,
      this.email,
      this.idCard,
      this.accountID});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] as String,
      dob: json['birthday'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String,
      email: json['email'] as String,
      idCard: json['idCard'] as String,
      profileId: json['profileId'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "profileId": this.profileId,
        "fullName": this.fullName,
        "birthday": this.dob,
        "gender": this.gender,
        "phone": this.phone,
        "image": this.image,
        "email": this.email,
        "idCard": this.idCard,
        "accountID": this.accountID,
      };
}
