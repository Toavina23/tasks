import 'package:get_it/get_it.dart';
import 'package:tasks/data/datasources/category/category_local_datasource.dart';
import 'package:tasks/data/datasources/project/project_local_datasource.dart';
import 'package:tasks/data/datasources/task/task_local_datasource.dart';
import 'package:tasks/data/repositories/category_repository_impl.dart';
import 'package:tasks/data/repositories/project_repository_impl.dart';
import 'package:tasks/domain/repositories/category_repository.dart';
import 'package:tasks/domain/usecases/project_detail/get_project_details.dart';
import 'package:tasks/domain/usecases/projectList/delete_item.dart';
import 'package:tasks/domain/usecases/projectList/add_project.dart';
import 'package:tasks/domain/usecases/projectList/get_all_projects.dart';
import 'package:tasks/domain/usecases/projectList/get_project_categories.dart';
import 'package:tasks/domain/usecases/project_detail/save_new_task.dart';
import 'package:tasks/presentation/blocs/projectDetail/project_detail_bloc.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_bloc.dart';
import 'package:tasks/domain/usecases/project_detail/delete_project_task.dart'
    as d;

var getIt = GetIt.instance;

Future<void> initialize() async {
  //services
  //datasources
  getIt.registerLazySingleton<ProjectLocalDatasource>(
      () => ProjectLocalDatasource());
  getIt.registerLazySingleton<CategoryLocalDataSource>(
      () => const CategoryLocalDataSource());
  getIt.registerLazySingleton<TaskLocalDatasource>(() => TaskLocalDatasource());

  //repositories
  getIt.registerLazySingleton<ProjectRepositoryImpl>(
    () => ProjectRepositoryImpl(
      taskDatasource: getIt.get<TaskLocalDatasource>(),
      projectDataSource: getIt.get<ProjectLocalDatasource>(),
    ),
  );
  getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(getIt.get<CategoryLocalDataSource>()));

  //usecases
  getIt.registerLazySingleton<GetAllProjects>(
    () => GetAllProjects(
      projectRepository: getIt.get<ProjectRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<AddProject>(
    () => AddProject(
      getIt.get<ProjectRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<DeleteProject>(
    () => DeleteProject(
      getIt.get<ProjectRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<GetProjectDetails>(
    () => GetProjectDetails(
      getIt.get<ProjectRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<GetProjectCategories>(
    () => GetProjectCategories(
      getIt.get<CategoryRepository>(),
    ),
  );
  getIt.registerLazySingleton<SaveNewProjectTask>(
    () => SaveNewProjectTask(
      getIt.get<ProjectRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<d.DeleteProjectTask>(
    () => d.DeleteProjectTask(
      getIt.get<ProjectRepositoryImpl>(),
    ),
  );

  //blocs
  getIt.registerFactory<ProjectListBloc>(
    () => ProjectListBloc(
      getIt.get<GetAllProjects>(),
      getIt.get<AddProject>(),
      getIt.get<DeleteProject>(),
      getIt.get<GetProjectCategories>(),
    ),
  );

  getIt.registerFactory(
    () => ProjectDetailBloc(
      getIt.get<GetProjectDetails>(),
      getIt.get<SaveNewProjectTask>(),
      getIt.get<d.DeleteProjectTask>(),
    ),
  );
}
