class Badge {
  String id;
  String title;
  String description;
  String image;
  List frequency = [];

  Badge({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.frequency = const [],
  });
  Badge.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        description = data['description'],
        image = data['image'],
        frequency = data['frequency'];

  get getid => id;
  get gettitle => title;
  get getdescription => description;
  get getimage => image;
  get getfrequency => frequency;
}
