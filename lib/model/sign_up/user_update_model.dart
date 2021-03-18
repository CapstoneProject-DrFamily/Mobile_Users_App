class UserUpdateModel {
  final String updBy, username, password, updDate;
  final int roleId, accountId, disable, waiting;

  UserUpdateModel(
      {this.disable,
      this.updBy,
      this.updDate,
      this.accountId,
      this.username,
      this.password,
      this.roleId,
      this.waiting});

  Map<String, dynamic> toJson() => {
        "disabled": disable,
        "updBy": updBy,
        "updDatetime": updDate,
        "accountId": accountId,
        "username": username,
        "password": password,
        "roleId": roleId,
        "waiting": waiting
      };
}
