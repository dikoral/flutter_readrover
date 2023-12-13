import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final int age;

  UserModel({required this.id, required this.email, this.name = '', this.age = 0});

  factory UserModel.fromFirebase(User firebaseUser, {String name = '', int age = 0}) {
    return UserModel(
      id: firebaseUser.uid, 
      email: firebaseUser.email ?? '',
      name: name,
      age: age,
    );
  }
}