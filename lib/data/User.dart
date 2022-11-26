// ignore_for_file: unnecessary_this, file_names, non_constant_identifier_names

class User {
  //PARAMETERS
  String? firstname = "tester";
  String? lastname;
  int? age;
  String? gender;
  String? email;
  String? password;
  List? _reminders;
  List? _badges;

  //SETTER & GETTERS
  get fname => this.firstname;
  set fname(value) => this.firstname = value;

  get lname => this.lastname;
  set lname(value) => this.lastname = value;

  get getAge => this.age;
  set setAge(age) => this.age = age;

  get getGender => this.gender;
  set setGender(gender) => this.gender = gender;

  get getEmail => this.email;
  set setEmail(email) => this.email = email;

  get getPassword => this.password;
  set setPassword(password) => this.password = password;

  get reminders => this._reminders;
  set reminders(value) => this._reminders = value;

  get badges => this._badges;
  set badges(value) => this._badges = value;

  //CONSTRUCTOR
  User(
      {this.firstname,
      this.lastname,
      this.age,
      this.gender,
      this.email,
      this.password});
}
