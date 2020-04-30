class Category {
  final String id;
  final String urlParam;
  final String name;
  final String parentId;

  Category({
    this.id,
    this.urlParam,
    this.name,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      urlParam: json['url_param'],
      name: json['name'],
      parentId: json['parent_id'],
    );
  }
}
