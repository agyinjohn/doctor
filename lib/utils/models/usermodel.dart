import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

// Define the Role enum
enum Role { admin, user, doctor, mentor, counsellor }

class UserModel {
  final String name;
  final String email;
  final String uid;
  final String profileUrl;
  final String speciality;
  final Role role; // Add the role field

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.profileUrl,
    required this.speciality,
    required this.role,
  });

  // Map to convert Role enum to string
  static String roleToString(Role role) {
    return role.toString().split('.').last;
  }

  // Map to convert string to Role enum
  static Role stringToRole(String role) {
    return Role.values.firstWhere((r) => r.toString().split('.').last == role);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uid': uid,
      'speciality': speciality,
      'profileUrl': profileUrl,
      'role': roleToString(role), // Convert role to string
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      uid: map['uid'] as String? ?? '',
      speciality: map['speciality'] as String? ?? '',
      profileUrl: map['profileUrl'] as String? ?? '',
      role: map['role'] != null
          ? stringToRole(map['role'] as String)
          : Role.user, // Default to user role
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) {
    if (source.isEmpty) {
      throw ArgumentError('The provided JSON string is null or empty');
    }

    return UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
