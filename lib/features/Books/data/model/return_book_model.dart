class ReturnBookModel {
  String? status;
  PaginationData? data;

  ReturnBookModel({this.status, this.data});

  ReturnBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? PaginationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaginationData {
  int? currentPage;
  List<RequestData>? requestData;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  PaginationData({
    this.currentPage,
    this.requestData,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  PaginationData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      requestData = <RequestData>[];
      json['data'].forEach((v) {
        requestData!.add(RequestData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (requestData != null) {
      data['data'] = requestData!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class RequestData {
  int? requestId;
  int? studentId;
  int? bookId;
  dynamic projectId;
  String? dateOfRequest;
  dynamic notes;
  String? status;
  String? type;
  String? createdAt;
  String? updatedAt;
  BookData? book;

  RequestData(
      {this.requestId,
        this.studentId,
        this.bookId,
        this.projectId,
        this.dateOfRequest,
        this.notes,
        this.status,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.book});

  RequestData.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    studentId = json['student_id'];
    bookId = json['book_id'];
    projectId = json['project_id'];
    dateOfRequest = json['date_of_request'];
    notes = json['notes'];
    status = json['status'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    book = json['book'] != null ? BookData.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    data['student_id'] = studentId;
    data['book_id'] = bookId;
    data['project_id'] = projectId;
    data['date_of_request'] = dateOfRequest;
    data['notes'] = notes;
    data['status'] = status;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    return data;
  }
}

class BookData {
  int? bookId;
  String? bookName;
  String? author;
  String? isbnNo;
  int? bookNo;
  String? price;
  String? source;
  String? summary;
  String? department;
  String? status;
  String? place;
  String? shelfNo;
  int? size;
  String? releaseDate;
  String? libraryDate;
  String? image;
  dynamic createdAt;
  String? updatedAt;

  BookData(
      {this.bookId,
        this.bookName,
        this.author,
        this.isbnNo,
        this.bookNo,
        this.price,
        this.source,
        this.summary,
        this.department,
        this.status,
        this.place,
        this.shelfNo,
        this.size,
        this.releaseDate,
        this.libraryDate,
        this.image,
        this.createdAt,
        this.updatedAt});

  BookData.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookName = json['book_name'];
    author = json['author'];
    isbnNo = json['isbn_no'];
    bookNo = json['book_no'];
    price = json['price'];
    source = json['source'];
    summary = json['summary'];
    department = json['department'];
    status = json['status'];
    place = json['place'];
    shelfNo = json['shelf_no'];
    size = json['size'];
    releaseDate = json['release_date'];
    libraryDate = json['library_date'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['book_id'] = this.bookId;
    data['book_name'] = this.bookName;
    data['author'] = this.author;
    data['isbn_no'] = this.isbnNo;
    data['book_no'] = this.bookNo;
    data['price'] = this.price;
    data['source'] = this.source;
    data['summary'] = this.summary;
    data['department'] = this.department;
    data['status'] = this.status;
    data['place'] = this.place;
    data['shelf_no'] = this.shelfNo;
    data['size'] = this.size;
    data['release_date'] = this.releaseDate;
    data['library_date'] = this.libraryDate;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}