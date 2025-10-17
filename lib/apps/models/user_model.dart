class UserModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String token;
  final String phone;
  final String location;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.token,
    required this.phone,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    
    Map<String,dynamic> personalData = json['personal_data'] ?? [];
    return UserModel(
      id: json['id'],
      name: json['name'] ?? 'null',
      username: json['username'] ?? 'null',
      email: json['email'] ?? 'null',
      token: json['token'] ?? 'null',
      phone: personalData['phone_number'] ?? 'null',
      location: personalData['location'] ?? 'null',
    );
  }
}
