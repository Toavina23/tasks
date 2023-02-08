import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/domain/usecases/projectDetail/get_project_details.dart';
part 'project_detail_state.dart';
part 'project_detail_event.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  final GetProjectDetails _getProjectDetails;
  ProjectDetailBloc(this._getProjectDetails)
      : super(const ProjectDetailState()) {
    on<FetchProjectDetailEvent>(_onFetchProjectDetailEvent);
  }
  _onFetchProjectDetailEvent(
      FetchProjectDetailEvent event, Emitter<ProjectDetailState> emit) async {
    emit(state.copyWith(
      status: () => ProjectDetailStatus.loading,
    ));
    Either<Failure, ProjectEntity> result =
        await _getProjectDetails.execute(event.projectId);
    result.fold(
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
      (data) {
        emit(
          state.copyWith(
              status: () => ProjectDetailStatus.loaded, project: () => data),
        );
      },
    );
  }
}
