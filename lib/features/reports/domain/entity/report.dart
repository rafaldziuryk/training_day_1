class Report {
  final String title;
  final String description;
  final DateTime date;
  final String server;
  final bool isOk;

  const Report({
    required this.title,
    required this.description,
    required this.date,
    required this.server,
    required this.isOk,
  });
}
