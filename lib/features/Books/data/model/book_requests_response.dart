class BookRequestResponseModel {
  String? status;
  String? message; // إضافة حقل الرسالة
  PaginationData? data;

  BookRequestResponseModel({this.status, this.message, this.data});

  BookRequestResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']; // إضافة تحليل الرسالة من JSON
    data = json['data'] != null ? PaginationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message; // إضافة الرسالة إلى JSON
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaginationData {
  int? currentPage;
  List<RequestItem>? data; // هذه هي قائمة الطلبات الفعلية
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  PaginationData({
    this.currentPage,
    this.data,
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
      data = <RequestItem>[];
      json['data'].forEach((v) {
        data!.add(RequestItem.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Link>[];
      json['links'].forEach((v) {
        links!.add(Link.fromJson(v));
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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

class RequestItem {
  int? requestId;
  int? studentId;
  int? bookId;
  int? projectId; // يمكن أن يكون null
  String? dateOfRequest;
  String? notes; // يمكن أن يكون null
  String? status;
  String? type;
  String? createdAt;
  String? updatedAt;
  Book? book;

  RequestItem({
    this.requestId,
    this.studentId,
    this.bookId,
    this.projectId,
    this.dateOfRequest,
    this.notes,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.book,
  });

  RequestItem.fromJson(Map<String, dynamic> json) {
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
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
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
    if (book != null) {
      data['book'] = book!.toJson();
    }
    return data;
  }
}

class Book {
  int? bookId;
  String? bookName;
  String? author;
  String? isbnNo;
  int? bookNo;
  String? price;
  String? source;
  String? summary;
  String? department;
  String? status; // في الاستجابة "in_reading" أو "available"
  String? place;
  String? shelfNo;
  int? size;
  String? releaseDate;
  String? libraryDate;
  String? image; // يمكن أن يكون null
  String? createdAt; // يمكن أن يكون null
  String? updatedAt;

  Book({
    this.bookId,
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
    this.updatedAt,
  });

  Book.fromJson(Map<String, dynamic> json) {
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
    data['book_id'] = bookId;
    data['book_name'] = bookName;
    data['author'] = author;
    data['isbn_no'] = isbnNo;
    data['book_no'] = bookNo;
    data['price'] = price;
    data['source'] = source;
    data['summary'] = summary;
    data['department'] = department;
    data['status'] = status;
    data['place'] = place;
    data['shelf_no'] = shelfNo;
    data['size'] = size;
    data['release_date'] = releaseDate;
    data['library_date'] = libraryDate;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Link {
  String? url; // يمكن أن يكون null
  String? label;
  bool? active;

  Link({this.url, this.label, this.active});

  Link.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}