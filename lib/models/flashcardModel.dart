class FlashcardModel {
  final List<String> terms = ["Math", "Physics", "Biology"];
  final List<String> definitions = [
    "Math Definition",
    "Physics definition",
    "Biology Definition",
  ];
  int queue = 0;
  FlashcardModel() {
    queue = terms.length;
  }

  void pop() {
    if(queue > 0)
      queue--;
  }

  void push() {
    if(queue < terms.length)
      queue++;
  }
}
