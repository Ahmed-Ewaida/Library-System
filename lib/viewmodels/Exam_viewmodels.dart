import '../modules/Exam_modules.dart';

class StudyProgramViewModels{
  final List<ProgramModel> programs=[
    ProgramModel(id: 1, name: 'البرنامج العام'),
    ProgramModel(id: 2, name: 'البرامج الخاصة')
  ];
}
class AcademicYearViewModel{
  final List<AcademicYearModel> allYears=[
    AcademicYearModel(
      id: "1",
      name: 'الفرقة الأولى',
    ),
    AcademicYearModel(
      id: "2",
      name: 'الفرقة الثانية',
    ),
    AcademicYearModel(
      id: "3",
      name: 'الفرقة الثالثة',
    ),
    AcademicYearModel(
      id: "4",
      name: 'الفرقة الرابعة',
    ),

  ];
}

class SemesterViewModel {
  final List <SemesterModel>  Semesters=[
    SemesterModel(
      id: "first",
      name: 'الفصل الدراسي الأول',
    ),
    SemesterModel(
      id: "second",
      name: 'الفصل الدراسي الثانى',
    ),
  ];
}
class DepartmentSelection {
  final List<Departments> deprtment=[
    Departments(
      id: "is",
      name: 'قسم نظم المعلومات',
    ),
    Departments(
      id: "cs",
      name: 'قسم علوم الحاسب',
    ),
    Departments(
      id: "it",
      name: 'قسم تكنولوجيا المعلومات',
    ),
    Departments(
      id: "ds",
      name: 'قسم دعم القرار',
    ),

  ];
}