class CategoryModel {
  final int? id;
  final String name;

  CategoryModel({this.id, required this.name});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {if (id != null) 'id': id, 'name': name};
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => toMap();
}
