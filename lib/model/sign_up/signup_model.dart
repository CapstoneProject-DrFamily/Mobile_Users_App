class SignUpModel {
  // final String fullName, dob, gender, phone, image, email, idCard;
  final String fullName,
      dob,
      gender,
      image,
      email,
      idCard,
      relationship,
      bloodType,
      location;
  final double height, weight;
  final int accountID;

  // SignUpModel(
  //     {this.fullName,
  //     this.dob,
  //     this.gender,
  //     this.phone,
  //     this.image,
  //     this.email,
  //     this.idCard,
  //     this.accountID});

  SignUpModel(
      {this.fullName,
      this.dob,
      this.image,
      this.idCard,
      this.email,
      this.gender,
      this.height,
      this.weight,
      this.bloodType,
      this.relationship,
      this.location,
      this.accountID});

  // Map<String, dynamic> toJson() => {
  //       "fullName": fullName,
  //       "birthday": dob,
  //       "gender": gender,
  //       "phone": phone,
  //       "image": image,
  //       "email": email,
  //       "idCard": idCard,
  //       "accountId": accountID,
  //     };

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "birthday": dob,
        "image": image,
        "idCard": idCard,
        "email": email,
        "gender": gender,
        "height": height,
        "weight": weight,
        "bloodType": bloodType,
        "relationship": relationship,
        "location": location,
        "accountId": accountID,
      };
}
