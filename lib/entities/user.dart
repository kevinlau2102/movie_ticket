class User {
  String? email;
  String? name;
  String? password;
  int? balance;

  User({this.email, this.name, this.password, this.balance});

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        email: json['email'],
        balance: json['balance'],
        password: json['password'],
      );
}
