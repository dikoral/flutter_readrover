import 'package:flutter_readrover/Data/Models/UserModel.dart';
import 'package:flutter_readrover/Data/Repository/UserRepository.dart';

class SignInUseCase {
  final AuthenticationRepository repository;

  SignInUseCase(this.repository);

  Future<UserModel> execute(String email, String password) {
    return repository.signIn(email, password);
  }
}

class SignUpUseCase {
  final AuthenticationRepository repository;

  SignUpUseCase(this.repository);

  Future<UserModel> execute(String email, String password, String name, int age) {
    return repository.signUp(email, password, name, age);
  }
}