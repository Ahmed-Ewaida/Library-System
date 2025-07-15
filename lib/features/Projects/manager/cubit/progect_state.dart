
import 'package:t1/features/Projects/data/model/projects_model.dart';

abstract class AllProjectState {}

class AllProjectInitial extends AllProjectState {}

class AllProjectLoading extends AllProjectState {}

class AllProjectError extends AllProjectState {
  String message;
  AllProjectError({required this.message});
}
class AllProjectSuccess extends AllProjectState {
  // Change the type to the new books model
  final ProjectsModel allProjectData; // Use 'BooksModel' class here
  AllProjectSuccess({required this.allProjectData});
}

abstract class ProjectDetailsState {}

class ProjectDetailsInitial extends ProjectDetailsState {}

class ProjectDetailsLoading extends ProjectDetailsState {}

class ProjectDetailsError extends ProjectDetailsState {
  final String message;
  ProjectDetailsError({required this.message});
}

class ProjectDetailsSuccess extends ProjectDetailsState {
  final Projects project; // هنا نحمل كائن المشروع الواحد فقط
  ProjectDetailsSuccess({required this.project});
}