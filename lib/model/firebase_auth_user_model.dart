class FireBaseAuthUserModel {
  static const NUMBER = 'number';
  static const ID = 'id';

  final String number;
  final String id;

  FireBaseAuthUserModel({this.number, this.id});

  factory FireBaseAuthUserModel.fromJson(Map<String, dynamic> json) {
    return FireBaseAuthUserModel(
        id: json[ID] as String, number: json[NUMBER] as String);
  }
}
