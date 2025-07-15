class Search {
  int? id;
  String? title;
  String? subtitle;
  String? type;

  Search({this.id, this.title, this.subtitle, this.type});

  Search.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['type'] = this.type;
    return data;
  }
}