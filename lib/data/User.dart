// ignore_for_file: unnecessary_this

class User {
  //PARAMETERS
  String? first_name;
  String? last_Name;
  int? age;
  String? gender;
  String? email;
  String? password;
  List? _reminders;
  List? _badges;

  //SETTER & GETTERS
  get firstname => this.first_name;
  set firstname(value) => this.first_name = value;

  get lastName => this.last_Name;
  set lastName(value) => this.last_Name = value;

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
      {this.first_name,
      this.last_Name,
      this.age,
      this.gender,
      this.email,
      this.password});
}
