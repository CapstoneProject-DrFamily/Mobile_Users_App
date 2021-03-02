class LandingModel {
  String fullName, image;

  LandingModel({this.fullName, this.image});

  factory LandingModel.fromJson(Map<String, dynamic> json) {
    return LandingModel(
      fullName: json['fullName'] as String,
      image: json['image'] as String,
    );
  }
}
