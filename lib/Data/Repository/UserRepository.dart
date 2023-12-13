
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_readrover/Data/DataSource/UserDataSource.dart';
import 'package:flutter_readrover/Data/Models/UserModel.dart';

class AuthenticationRepository {
  final AuthenticationDataSource dataSource;
  final FirebaseFirestore firestore;
  AuthenticationRepository({required this.dataSource, required this.firestore});
  Future<UserModel> signIn(String email, String password) async {
    var userCredential =
        await dataSource.signInWithEmailAndPassword(email, password);
    return UserModel.fromFirebase(userCredential.user!);
  }

    Future<UserModel> signUp(String email, String password, String name, int age) async {
    var userCredential = await dataSource.createUserWithEmailAndPassword(email, password);
    UserModel user = UserModel.fromFirebase(userCredential.user!, name: name, age: age);
    await firestore.collection("users").doc(user.id).set({
      'name': name,
      'age': age,
      'email': email,
    });
    return user;
  }
}
