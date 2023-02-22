import 'package:tasks/core/errors/exceptions.dart';
import 'package:tasks/data/datasources/project/project_datasource.dart';
import 'package:tasks/data/datasources/task/task_datasource.dart';
import 'package:tasks/data/models/category_model.dart';
import 'package:tasks/data/models/project_model.dart';
import 'package:tasks/data/models/task_model.dart';
import 'package:tasks/domain/entities/category_entity.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/subjects.dart';
import 'package:tasks/domain/entities/task_entity.dart';
import 'package:tasks/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDataSource projectDataSource;
  final TaskDatasource taskDatasource;
  final _taskStreamController =
      BehaviorSubject<List<TaskEntity>>.seeded(const []);
  ProjectRepositoryImpl(
      {required this.projectDataSource, required this.taskDatasource});

  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async {
    try {
      List<ProjectModel> projectModels = await projectDataSource.getProjects();
      List<ProjectEntity> projectEntities =
          projectModels.map((projectModel) => projectModel.toEntity()).toList();
      return right(projectEntities);
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> addProject(
      String projectName, CategoryEntity category) async {
    Map<String, dynamic> project = {};
    Map<String, dynamic> categoryMap =
        CategoryModel.fromEntity(category).toMap();
    project.addAll({
      "name": projectName,
      "categoryId": categoryMap["id"],
      "createdAt": DateTime.now().millisecondsSinceEpoch
    });
    try {
      ProjectModel newProject = await projectDataSource.saveProject(project);
      return right(newProject.toEntity());
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(int projectId) async {
    try {
      await projectDataSource.deleteProject(projectId);
      return right(null);
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Object>>> getProject(int projectId) async {
    try {
      ProjectModel projectModel = await projectDataSource.getProject(projectId);
      List<TaskModel> taskModels =
          await taskDatasource.getProjectTasks(projectId, null);
      _taskStreamController.add(
        taskModels
            .map(
              (task) => task.toEntity(),
            )
            .toList(),
      );
      return right(
          [projectModel.toEntity(), _taskStreamController.asBroadcastStream()]);
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    } catch (_) {
      return left(const AppFailure(
          "An unexpected error happened during the operation"));
    }
  }

  @override
  Future<Either<Failure, void>> addNewProjectTask(
      String taskName, int projectId) async {
    try {
      TaskModel taskModel =
          await taskDatasource.saveProjectTask(taskName, projectId);
      final tasks = [..._taskStreamController.value];
      tasks.add(taskModel.toEntity());
      return right(_taskStreamController.add(tasks));
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    } catch (_) {
      return left(const AppFailure(
          "An unexpected error happened during the operation"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProjectTask(int taskId) async {
    try {
      await taskDatasource.deleteProjectTask(taskId);

      final tasks = [..._taskStreamController.value];
      int taskIndex = tasks.indexWhere((element) => element.id == taskId);
      if (taskIndex != -1) {
        tasks.removeAt(taskIndex);
      }
      return right(_taskStreamController.add(tasks));
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    } catch (_) {
      return left(const AppFailure(
          "An unexpected error happened during the operation"));
    }
  }
}
