import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/domain/usecases/projectList/delete_item.dart';
import 'package:tasks/domain/usecases/projectList/add_project.dart';
import 'package:tasks/domain/usecases/projectList/get_all_projects.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_event.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  final GetAllProjects _getAllProjects;
  final AddProject _addProject;
  final DeleteProject _deleteProjectListItem;
  ProjectListBloc(
      this._getAllProjects, this._addProject, this._deleteProjectListItem)
      : super(ProjectListEmpty()) {
    on<FetchProjectListEvent>(_onFetchProjectList);
    on<AddProjectToListEvent>(_onAddProjectToList);
    on<DeleteProjectListItem>(_onDeleteProjectListItem);
  }

  _onFetchProjectList(
      FetchProjectListEvent event, Emitter<ProjectListState> emit) async {
    emit(ProjectListLoading());
    Either<Failure, List<ProjectEntity>> result =
        await _getAllProjects.execute();
    result.fold((failure) {
      if (failure is AppFailure) {
        emit(ProjectListFailure(failure.message));
      }
    }, (data) {
      if (data.isEmpty) {
        emit(ProjectListEmpty());
      } else {
        emit(ProjectListHasData(results: data));
      }
    });
  }

  _onAddProjectToList(
      AddProjectToListEvent event, Emitter<ProjectListState> emit) async {
    Either<Failure, ProjectEntity> operationResult = await _addProject.execute(
        {"name": event.projectName, "description": event.projectDescription});
    operationResult.fold((failure) {
      if (failure is AppFailure) {
        emit(NewProjectAddFailure(failure.message));
      }
    }, (_) async {
      emit(NewProjectAdded());
      add(FetchProjectListEvent());
    });
  }

  _onDeleteProjectListItem(
      DeleteProjectListItem event, Emitter<ProjectListState> emit) async {
    Either<Failure, void> operationResult =
        await _deleteProjectListItem.execute(event.projectId);
    operationResult.fold((failure) {
      if (failure is AppFailure) {
        emit(ProjectDeteleFailure(failure.message));
      }
    }, (_) {
      emit(ProjectDeleted());
      add(FetchProjectListEvent());
    });
  }
}
