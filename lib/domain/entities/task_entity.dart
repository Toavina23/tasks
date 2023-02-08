import 'package:intl/intl.dart';
import 'package:tasks/data/models/task_model.dart';
import 'package:tasks/domain/entities/project_entity.dart';

class TaskEntity {
  final int id;
  final String name;
  final DateTime createdAt;
  final TaskStatus status;
  final int executionTime;
  final TaskEntity? parent;
  final ProjectEntity? project;

  const TaskEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.status,
    this.executionTime = 0,
    this.parent,
    this.project,
  });

  String get displayDurationTime {
    DateTime datetime = DateTime(1999);
    datetime.add(Duration(seconds: executionTime));
    return DateFormat.Hms().format(datetime);
  }
}
