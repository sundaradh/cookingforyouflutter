// ignore_for_file: non_constant_identifier_names

class kRecipe {
  final String name;
  final String image;
  final String totalTime;
  final String description;
  final String ingredients;
  final String instructions;
  final String video;
  final String calories_food;

  kRecipe({
    required this.name,
    required this.image,
    required this.totalTime,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.video,
    required this.calories_food,
  });

  factory kRecipe.fromJson(dynamic json) {
    return kRecipe(
      name: json['name'] as String,
      image: json['image'] as String,
      totalTime: json['cooking_time'] as String,
      description: json['description'] as String,
      ingredients: json['ingredients'] as String,
      instructions: json['instructions'] as String,
      video: json['video'] as String,
      calories_food: json['calories_food'] as String,
    );
  }

  static List<kRecipe> recipesFromSnapshot(List snapshot, String query) {
    return snapshot.map((json) => kRecipe.fromJson(json)).where((book) {
      final nameLower = book.name.toLowerCase();

      final caloryLower = book.calories_food.toLowerCase();
      final cookingtimeLower = book.totalTime.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          caloryLower.contains(searchLower) ||
          cookingtimeLower.contains(searchLower);
    }).toList();
  }

  @override
  String toString() {
    return 'kRecipe {image: $image, rating:"5", totalTime: $totalTime}';
  }
}
