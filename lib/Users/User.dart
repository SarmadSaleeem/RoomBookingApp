class User{

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? gender ;
  final String? phoneNo;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.gender,
    this.phoneNo,
  });

  factory User.fromJson(Map<String, dynamic> json){

    final id = json["id"];
    final firstName = json["firstName"];
    final lastName = json["lastName"];
    final gender = json["gender"];
    final email = json["email"];
    final phoneNo = json["phoneNumber"];

    return User(
      id: id ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      gender: gender ?? "",
      email: email ?? "",
      phoneNo: phoneNo ?? ""
    );
  }
}