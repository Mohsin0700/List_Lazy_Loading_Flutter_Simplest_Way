class Product {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  Category? category;
  List<String>? images;

  Product({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['price'] = price;
    data['description'] = description;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['images'] = images;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? image;

  Category({this.id, this.name, this.slug, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    return data;
  }
}
