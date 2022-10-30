class Validator {
  Validator({required this.email, required this.password, required this.username});
  final String email;
  final String password;
  final String username;
  bool checkEmail() => email == "";
  bool checkPassword() => password == "";
  bool checkUsername() => username == "";
}
