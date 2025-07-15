import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Projects/data/repo/projects_repo.dart';
import 'package:t1/features/Projects/manager/cubit/progect_state.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  ProjectDetailsCubit() : super(ProjectDetailsInitial());

  final ProjectsRepo _repo = ProjectsRepo.getInstance();

  Future<void> fetchProjectDetails(int projectId) async {
    emit(ProjectDetailsLoading());
    final result = await _repo.getProjectDetails(projectId: projectId);

    result.fold(
          (failure) => emit(ProjectDetailsError(message: failure)),
          (project) => emit(ProjectDetailsSuccess(project: project)),
    );
  }
}