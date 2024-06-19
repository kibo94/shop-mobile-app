class User {
  final String fullName;
  final String email;
  final String password;
  final String address;
  final String phone;
  final String city;

  User(
      {required this.email,
      required this.password,
      required this.fullName,
      required this.address,
      required this.phone,
      required this.city});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      phone: json['phone'],
      city: json['city'],
    );
  }
}
