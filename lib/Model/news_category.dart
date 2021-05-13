class NewsCategory {
  final int id;
  final String name;
  final int categoryCode;

  NewsCategory(this.id, this.name, this.categoryCode);

  NewsCategory.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.name = json["name"],
        this.categoryCode = json["category_code"];

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "category_code": this.categoryCode,
      };
}
