class ToDo {
  final String name;
  final String link;

  ToDo(this.name, this.link);

  static String getTitle(json) {
    if (json['title'] != null) {
      return json['title'];
    } else if (json['name'] != null) {
      return json['name'];
    } else {
      return "Untitled";
    }
  }

  ToDo.fromJson(Map<String, dynamic> json)
      : name = getTitle(json),
        link = json['url'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'link': link,
      };
}
