class Todo {
  final String name;
  final String link;

  Todo(this.name, this.link);

  Todo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        link = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'link': link,
      };
}
