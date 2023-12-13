abstract class AuthenticationEvent {}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;
  final int age;

  SignUpEvent(this.email, this.password, this.name, this.age);
}
