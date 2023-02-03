import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/domain/usecases/projectDetail/get_project_details.dart';
import 'package:tasks/presentation/blocs/projectDetail/project_detail_event.dart';
import 'package:tasks/presentation/blocs/projectDetail/project_detail_state.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  final GetProjectDetails _getProjectDetails;
  ProjectDetailBloc(this._getProjectDetails) : super(ProjectDetailIdle()) {
    on<FetchProjectDetailEvent>(_onFetchProjectDetailEvent);
  }
  _onFetchProjectDetailEvent(
      FetchProjectDetailEvent event, Emitter<ProjectDetailState> emit) async {
    emit(ProjectDetailLoading());
    Either<Failure, ProjectEntity> result =
        await _getProjectDetails.execute(event.projectId);
    result.fold((failure) {
      if (failure is AppFailure) {
        emit(ProjectDetailFailure(failure.message));
      }
    }, (data) {
      emit(ProjectDetailHasData(data));
    });
  }
}
