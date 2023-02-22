import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/data/models/task_model.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/domain/entities/task_entity.dart';
import 'package:tasks/domain/usecases/project_detail/delete_project_task.dart'
    as d;
import 'package:tasks/domain/usecases/project_detail/get_project_details.dart';
import 'package:tasks/domain/usecases/project_detail/save_new_task.dart';
part 'project_detail_state.dart';
part 'project_detail_event.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  final GetProjectDetails _getProjectDetails;
  final SaveNewProjectTask _saveNewProjectTask;
  final d.DeleteProjectTask _deleteProjectTask;
  ProjectDetailBloc(this._getProjectDetails, this._saveNewProjectTask,
      this._deleteProjectTask)
      : super(const ProjectDetailState()) {
    on<FetchProjectDetailEvent>(_onFetchProjectDetailEvent);
    on<AddNewProjectTask>(_onAddNewProjectTask);
    on<DeleteProjectTask>(_onDeleteProjectTask);
  }
  _onAddNewProjectTask(
      AddNewProjectTask event, Emitter<ProjectDetailState> emit) async {
    Either<Failure, void> result =
        await _saveNewProjectTask.execute(event.newTaskName, state.project!.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
            failure: () => failure, status: () => ProjectDetailStatus.failure),
      ),
      (data) => emit(
        state.copyWith(status: () => ProjectDetailStatus.newTaskAdded),
      ),
    );
  }

  _onDeleteProjectTask(
      DeleteProjectTask event, Emitter<ProjectDetailState> emit) async {
    Either<Failure, void> result =
        await _deleteProjectTask.execute(event.taskId);
    result.fold(
      (failure) => emit(
        state.copyWith(
            failure: () => failure, status: () => ProjectDetailStatus.failure),
      ),
      (_) {
        emit(
          state.copyWith(status: () => ProjectDetailStatus.taskDeleted),
        );
      },
    );
  }

  _onFetchProjectDetailEvent(
      FetchProjectDetailEvent event, Emitter<ProjectDetailState> emit) async {
    emit(state.copyWith(
      status: () => ProjectDetailStatus.loading,
    ));
    Either<Failure, List<Object>> result =
        await _getProjectDetails.execute(event.projectId);
    await result.fold(
      (failure) {
        if (failure is AppFailure) {
          emit(
            state.copyWith(
              status: () => ProjectDetailStatus.failure,
              failure: () => failure,
            ),
          );
        }
      },
      (data) async {
        ProjectEntity projectEntity = data[0] as ProjectEntity;
        Stream<List<TaskEntity>> taskStream =
            data[1] as Stream<List<TaskEntity>>;
        await emit.forEach<List<TaskEntity>>(
          taskStream,
          onData: (data) {
            return state.copyWith(
                status: () => ProjectDetailStatus.loaded,
                project: () => projectEntity,
                taskList: () => data);
          },
        );
      },
    );
  }
}
