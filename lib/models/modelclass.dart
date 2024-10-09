class Note {
  String id;
  String title;
  String note;

  Note({
    required this.id,
    required this.title,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
    };
  }

  Note.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        note = map['note'];
}

