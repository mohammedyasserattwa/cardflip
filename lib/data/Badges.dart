class Badges {
  //PARAMETERS
  String? name;
  String? image;
  String? description;

  //SETTERS & GETTERS
  get getName => name;
  set setName(name) => this.name = name;

  get getImage => image;
  set setImage(image) => this.image = image;

  get getDescription => description;
  set setDescription(description) => this.description = description;

  //CONSTRUCTOR
  Badges({this.name, this.description, this.image});
}
