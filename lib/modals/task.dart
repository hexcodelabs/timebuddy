class Task {
  int id;
  String date;
  String hour;
  String half;
  String task;
  String color;
  String previous;
  String next;

  Task(
      {this.id,
      this.date,
      this.hour,
      this.half,
      this.task,
      this.color,
      this.previous,
      this.next});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'hour': hour,
      'half': half,
      'task': task,
      'color': color,
      'previous': previous,
      'next': next
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'],
        date: map['date'],
        hour: map['hour'],
        half: map['half'],
        task: map['task'],
        color: map['color'],
        previous: map['previous'],
        next: map['next']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "hour": hour,
        "half": half,
        "task": task,
        "color": color,
        "previous": previous,
        "next": next,
      };
}
