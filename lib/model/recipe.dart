// ignore_for_file: non_constant_identifier_names

class Recipe {
  final String name;
  final String category;
  final String image;
  final String totalTime;
  final String description;
  final String ingredients;
  final String instructions;
  final String video;
  final String calories_food;

  Recipe({
    required this.name,
    required this.category,
    required this.image,
    required this.totalTime,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.video,
    required this.calories_food,
  });

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
      name: json['name'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      totalTime: json['cooking_time'] as String,
      description: json['description'] as String,
      ingredients: json['ingredients'] as String,
      instructions: json['instructions'] as String,
      video: json['video'] as String,
      calories_food: json['calories_food'] as String,
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot, String query) {
    return snapshot.map((json) => Recipe.fromJson(json)).where((book) {
      final nameLower = book.name.toLowerCase();
      final categoryLower = book.category.toLowerCase();
      final caloryLower = book.calories_food.toLowerCase();
      final cookingtimeLower = book.totalTime.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          categoryLower.contains(searchLower) ||
          caloryLower.contains(searchLower) ||
          cookingtimeLower.contains(searchLower);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {image: $image, rating:"5", totalTime: $totalTime}';
  }
}
