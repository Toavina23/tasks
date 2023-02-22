import 'package:equatable/equatable.dart';
import 'package:tasks/data/models/project_model.dart';
import 'package:tasks/domain/entities/task_entity.dart';

enum TaskStatus {
  inWork(1),
  done(2),
  waiting(0);

  const TaskStatus(this.value);
  final int value;
}

class TaskModel extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;
  final TaskStatus status;
  final int executionTime;
  final TaskModel? parent;
  final ProjectModel? project;

  const TaskModel(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.status,
      this.executionTime = 0,
      this.parent,
      this.project});

  @override
  List<Object?> get props => [id, name, createdAt, status, executionTime];

  static TaskStatus setStatus(int status) {
    switch (status) {
      case 0:
        return TaskStatus.waiting;
      case 1:
        return TaskStatus.inWork;
      default:
        return TaskStatus.done;
    }
  }

  factory TaskModel.fromSqlite(Map<String, dynamic> data) {
    return TaskModel(
        id: data["id"],
        name: data["name"],
        createdAt: DateTime.fromMillisecondsSinceEpoch(data["createdAt"]),
        status: setStatus(data["status"]),
        executionTime: data["executionTime"] ?? 0);
  }
  TaskEntity toEntity() {
    return TaskEntity(
        id: id,
        name: name,
        createdAt: createdAt,
        status: status,
        executionTime: executionTime,
        parent: parent?.toEntity(),
        project: project?.toEntity());
  }
}
