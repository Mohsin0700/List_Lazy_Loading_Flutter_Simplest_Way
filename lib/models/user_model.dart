class UserModel {
  final int id;
  final String name;
  final String email;
  UserModel({required this.name, required this.email, required this.id});

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(name: json['name'], email: json['email'], id: json['id']);
  }
}
