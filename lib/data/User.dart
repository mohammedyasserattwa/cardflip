// ignore_for_file: unnecessary_this, file_names, non_constant_identifier_names

class User {
  //PARAMETERS
  String firstname = "tester.com";
  String? lastname;
  int? age;
  String? gender;
  String email = "tester@gmail.com";
  String password = "tester123";
  List? _reminders;
  List? _badges;

  //SETTER & GETTERS
  get fname => firstname;
  set fname(value) => this.firstname = value;

  get lname => this.lastname;
  set lname(value) => this.lastname = value;

  get getAge => this.age;
  set setAge(age) => this.age = age;

  get getGender => this.gender;
  set setGender(gender) => this.gender = gender;

  get getEmail => email;
  set setEmail(email) => this.email = email;

  get getPassword => password;
  set setPassword(password) => this.password = password;

  get reminders => this._reminders;
  set reminders(value) => this._reminders = value;

  get badges => this._badges;
  set badges(value) => this._badges = value;
}
