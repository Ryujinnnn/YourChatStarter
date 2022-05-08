class ChangePasswordRequestModel {
  late String oldPassword;
  late String newPassword;
  late String confirmNewPassword;

  ChangePasswordRequestModel(
      {required this.oldPassword,
      required this.newPassword,
      required this.confirmNewPassword});

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
    confirmNewPassword = json['confirm_new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['old_password'] = oldPassword;
    data['new_password'] = newPassword;
    data['confirm_new_password'] = confirmNewPassword;
    return data;
  }
}
