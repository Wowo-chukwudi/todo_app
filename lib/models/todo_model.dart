class TodoModel {
  final String title;
  final String note;
  final String date;
  final String time;
  bool isDone;
  String id;
  DateTime createdTime;

  TodoModel(
      {required this.title,
      this.note = '',
      this.date = '',
      this.time = '',
      this.isDone = false,
      this.id = '',
      required this.createdTime});
}
