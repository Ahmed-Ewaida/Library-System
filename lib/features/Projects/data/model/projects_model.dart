class ProjectsModel {
  String? status;
  Data? data;

  ProjectsModel({this.status, this.data});

  ProjectsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Projects>? projects;
  Pagination? pagination;

  Data({this.projects, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Projects {
  int? projectId;
  String? projectName;
  String? department;
  String? status;
  String? supervisor;
  String? projectDate;
  String? image;
  bool? pdfAvailable;
  String? pdfUrl;
  String? place;
  String? shelfNo;

  Projects(
      {this.projectId,
        this.projectName,
        this.department,
        this.status,
        this.supervisor,
        this.projectDate,
        this.image,
        this.pdfAvailable,
        this.pdfUrl,
        this.place,
        this.shelfNo});

  Projects.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    department = json['department'];
    status = json['status'];
    supervisor = json['supervisor'];
    projectDate = json['project_date'];
    image = json['image'];
    pdfAvailable = json['pdf_available'];
    pdfUrl = json['pdf_url'];
    place = json['place'];
    shelfNo = json['shelf_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_name'] = this.projectName;
    data['department'] = this.department;
    data['status'] = this.status;
    data['supervisor'] = this.supervisor;
    data['project_date'] = this.projectDate;
    data['image'] = this.image;
    data['pdf_available'] = this.pdfAvailable;
    data['pdf_url'] = this.pdfUrl;
    data['place'] = this.place;
    data['shelf_no'] = this.shelfNo;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalItems;
  int? perPage;
  bool? hasNext;
  bool? hasPrevious;

  Pagination(
      {this.currentPage,
        this.totalPages,
        this.totalItems,
        this.perPage,
        this.hasNext,
        this.hasPrevious});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    totalItems = json['total_items'];
    perPage = json['per_page'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    data['total_items'] = this.totalItems;
    data['per_page'] = this.perPage;
    data['has_next'] = this.hasNext;
    data['has_previous'] = this.hasPrevious;
    return data;
  }
}
