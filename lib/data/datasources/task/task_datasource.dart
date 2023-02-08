import 'package:tasks/data/models/task_model.dart';

abstract class TaskDatasource {
  Future<List<TaskModel>> getProjectTasks(int projectId, int? parentTaskId);
}
