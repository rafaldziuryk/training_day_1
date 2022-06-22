class Report {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final String server;
  final bool isOk;

  const Report({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.server,
    required this.isOk,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'date': this.date,
      'server': this.server,
      'isOk': this.isOk,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      date: DateTime.parse(map['date']),
      server: map['server'] as String,
      isOk: map['isOk'] as bool,
    );
  }
}
