class Priority {
  int id;
  String date;
  int index;
  String priority;

  Priority({
    this.id,
    this.date,
    this.index,
    this.priority,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'index': index,
      'priority': priority,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static Priority fromMap(Map<String, dynamic> map) {
    return Priority(
      id: map['id'],
      date: map['date'],
      index: map['indexx'],
      priority: map['priority'],
    );
  }
}
