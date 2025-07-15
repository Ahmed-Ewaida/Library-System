class ProjectModel {
  final String projectname;
  final String drname;
  final String engname;
  final String department;
  final String location;
  final int projectnumber;
  final bool projectstatus;
  final String image;
  final double rate;

 ProjectModel({
    required this.projectname,
    required this.drname,
    required this.engname,
    required this.location,
   required this.department,
    required this.projectnumber,
    required this.projectstatus,
    required this.image,
    required this.rate,
  });
}
