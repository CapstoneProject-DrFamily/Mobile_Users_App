class SignUpModel {
  final String fullName, dob, gender, phone, image, email, idCard;
  final int accountID;

  SignUpModel(
      {this.fullName,
      this.dob,
      this.gender,
      this.phone,
      this.image,
      this.email,
      this.idCard,
      this.accountID});

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "birthday": dob,
        "gender": gender,
        "phone": phone,
        "image": image,
        "email": email,
        "idCard": idCard,
        "accountId": accountID,
      };
}
