class UserModel {
  final int idUser;
  final String username;
  final String email;
  final String password;

  UserModel(
      {required this.email,
      required this.idUser,
      required this.username,
      required this.password});

  factory UserModel.getDataFromJSON(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'] ?? '',
        idUser: json['id_user'] ?? 0,
        username: json['name'] ?? '',
        password: json['password'] ?? '');
  }
}
