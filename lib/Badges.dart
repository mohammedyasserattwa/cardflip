// ignore_for_file: unnecessary_this

class Badges {
  //PARAMETERS
  String? name;
  String? image;
  String? description;

  //SETTERS & GETTERS
  get getName => this.name;
  set setName(name) => this.name = name;

  get getImage => this.image;
  set setImage(image) => this.image = image;

  get getDescription => this.description;
  set setDescription(description) => this.description = description;

  //CONSTRUCTOR
  Badges({this.name, this.description, this.image});
}
