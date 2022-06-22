import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReportAdapter extends TypeAdapter<Report> {
  @override
  int get typeId => 0;

  @override
  Report read(BinaryReader reader) {
    final id = reader.readInt();
    final title = reader.readString();
    final description = reader.readString();
    final date = reader.readInt();
    final server = reader.readString();
    final isOk = reader.readBool();

    return Report(
      id: id,
      title: title,
      description: description,
      date: DateTime.fromMillisecondsSinceEpoch(date),
      server: server,
      isOk: isOk,
    );
  }

  @override
  void write(BinaryWriter writer, Report obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeString(obj.server);
    writer.writeBool(obj.isOk);
  }
}
