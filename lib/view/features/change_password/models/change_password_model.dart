
class  ChangePasswordModel {
  final String oldPassword;
  final String newPassword;
  final String  confirmNewPassword;

  ChangePasswordModel ({required this.oldPassword,required this.newPassword,required this.confirmNewPassword});


Map<String,dynamic>toJson(){
  return {

    'oldPassword':confirmNewPassword,
    'newPassword':confirmNewPassword,
    "confirmNewPassword":confirmNewPassword,

  };
}

}


