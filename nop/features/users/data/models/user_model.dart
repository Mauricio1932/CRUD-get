import '../../domain/entities/User.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String mail,
    required String phone,
    required String password,
  }) : super(id: id, name: name, mail: mail, phone: phone, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      mail: json['mail'],
      phone: json['phone'],
      password: json['password'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      mail: user.mail,
      phone: user.phone,
      password: user.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'phone': phone,
      'password': password,
    };
  }
}
