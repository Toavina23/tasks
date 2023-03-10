import 'package:get_it/get_it.dart';
import 'package:tasks/data/datasources/project/project_local_datasource_impl.dart';
import 'package:tasks/data/repositories/project_repository_impl.dart';
import 'package:tasks/domain/usecases/delete_item.dart';
import 'package:tasks/domain/usecases/project/add_project.dart';
import 'package:tasks/domain/usecases/project/get_all_projects.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_bloc.dart';

var getIt = GetIt.instance;

Future<void> initialize() async {
  //services
  //datasources
  getIt.registerLazySingleton<ProjectLocalDatasourceImpl>(
      () => ProjectLocalDatasourceImpl());

  //repositories
  getIt.registerLazySingleton<ProjectRepositoryImpl>(() =>
      ProjectRepositoryImpl(
          projectDataSource: getIt.get<ProjectLocalDatasourceImpl>()));
  //usecases
  getIt.registerLazySingleton<GetAllProjects>(() =>
      GetAllProjects(projectRepository: getIt.get<ProjectRepositoryImpl>()));
  getIt.registerLazySingleton<AddProject>(
      () => AddProject(getIt.get<ProjectRepositoryImpl>()));
  getIt.registerLazySingleton<DeleteProject>(
      () => DeleteProject(getIt.get<ProjectRepositoryImpl>()));
  //blocs
  getIt.registerFactory<ProjectListBloc>(() => ProjectListBloc(
      getIt.get<GetAllProjects>(),
      getIt.get<AddProject>(),
      getIt.get<DeleteProject>()));
}
