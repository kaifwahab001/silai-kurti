class UserModel {
  final String uId;
  final String usrname;
  final String email;
  final String password;
  final String phone_number;
  final String userImg;
  final String deviceToken; // Changed to camelCase for consistency
  final bool isAdmin;
  final bool isActive;
  final String country;
  final dynamic createdon;

  UserModel({
    required this.uId,
    required this.usrname,
    required this.email,
    required this.password,
    required this.phone_number,
    required this.userImg,
    required this.deviceToken, // Changed to camelCase for consistency
    required this.isAdmin,
    required this.isActive,
    required this.country,
    required this.createdon,
  });

  // Convert a UserModel instance to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'usrname': usrname,
      'email': email,
      'password': password,
      'phone_number': phone_number,
      'userImg': userImg,
      'deviceToken': deviceToken, // Keep original casing if needed
      'isAdmin': isAdmin,
      'isActive': isActive,
      'country': country,
      'createdon': createdon,
    };
  }

  // Convert a Map (JSON) to a UserModel instance
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      usrname: json['usrname'],
      email: json['email'],
      password: json['password'],
      phone_number: json['phone_number'],
      userImg: json['userImg'],
      deviceToken: json['DeviceToken'], // Keep original casing if needed
      isAdmin: json['isAdmin'],
      isActive: json['isActive'],
      country: json['country'],
      createdon: json['createdon'],
    );
  }
}