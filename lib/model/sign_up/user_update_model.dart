class UserUpdateModel {
  final String updBy, username, password, updDate;
  final int roleId, profileId, accountId, disable, waiting;

  UserUpdateModel(
      {this.disable,
      this.updBy,
      this.updDate,
      this.accountId,
      this.username,
      this.password,
      this.roleId,
      this.profileId,
      this.waiting});

  Map<String, dynamic> toJson() => {
        "disabled": disable,
        "updBy": updBy,
        "updDatetime": updDate,
        "accountId": accountId,
        "username": username,
        "password": password,
        "roleId": roleId,
        "profileId": profileId,
        "waiting": waiting
      };
}
