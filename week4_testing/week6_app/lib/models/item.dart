class Item {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String category;
  final DateTime createdAt;

  Item({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.category,
    required this.createdAt,
  });

  Item copyWith({
    String? title,
    String? subtitle,
    String? description,
    String? category,
  }) {
    return Item(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      category: category ?? this.category,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'description': description,
    'category': category,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json['id'] as String,
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}
