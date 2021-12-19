class UserModel {
  String id;
  String name;
  String phone;
  String email;
  String userType;

  UserModel({this.id, this.name, this.phone, this.email, this.userType});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return new UserModel(
      id: map['id'] as String ?? "",
      name: map['name'] as String ?? "",
      phone: map['phone'] as String ?? "",
      email: map['email'] as String ?? "",
      userType: map['userType'] as String ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'phone': this.phone,
      'email': this.email,
      'userType': this.userType,
    } as Map<String, dynamic>;
  }
}
