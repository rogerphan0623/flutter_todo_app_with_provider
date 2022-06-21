class TodoFiled {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Todo({
    required this.title,
    required this.createdTime,
    this.description = '',
    required this.id,
    this.isDone = false,
  });
}
