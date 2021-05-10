class NewsCategory {
  final String id;
  final String category; //This is used to filter by category
  final String categoryName;

  NewsCategory(this.id, this.category, this.categoryName);

  NewsCategory.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.category = json["category"],
        this.categoryName = json["category_name"];

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "category": this.category,
        "category_name": this.categoryName
      };
}
