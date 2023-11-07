class Item {
  String description;

  Item({
    required this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(description: json['description']);

  Map<String, dynamic> toJson() => {'description': description};
}
