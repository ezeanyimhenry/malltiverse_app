class Category {
  final String id;
  final String name;
  final String organizationId;
  final bool isDeleted;
  final String description;
  final String categoryType;
  final List<dynamic> subcategories;
  final List<dynamic> entityItems;
  final List<dynamic> parents;
  final List<dynamic> photos;
  final String? urlSlug;

  Category({
    required this.id,
    required this.name,
    required this.organizationId,
    required this.isDeleted,
    required this.description,
    required this.categoryType,
    required this.subcategories,
    required this.entityItems,
    required this.parents,
    required this.photos,
    this.urlSlug,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      organizationId: json['organization_id'],
      isDeleted: json['is_deleted'],
      description: json['description'],
      categoryType: json['category_type'],
      subcategories: json['subcategories'],
      entityItems: json['entity_items'],
      parents: json['parents'],
      photos: json['photos'],
      urlSlug: json['url_slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'organization_id': organizationId,
      'is_deleted': isDeleted,
      'description': description,
      'category_type': categoryType,
      'subcategories': subcategories,
      'entity_items': entityItems,
      'parents': parents,
      'photos': photos,
      'url_slug': urlSlug,
    };
  }
}
